class User < ActiveRecord::Base
  
  has_many :descriptors, :dependent => :destroy
  has_many :tags, :through => :descriptors
  
  has_many :authentications
  
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, # :registerable,
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable #, :invite_for => 0 #0 is default and mean s invitation does not expire, 2.weeks #devise_invitable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :last_name, :first_name, :role, :company, :company_website, :website, :twitter, :show_email, :visible, :title, :bio,
                  :github, :dribble, :linkedin, :forrst, :stackoverflow,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at,
                  :image, :tag_tokens, :tag_ids, :invitation_limit
  
  #Validations
   validates_presence_of :password, :if => :should_validate_password?
   attr_accessor :updating_password, :new_user #Conditional Validation
   
   
   #Many to Many
   after_save :update_tags #update_tags is a method below

  #Will_Paginate
  cattr_reader :per_page
  @@per_page = 6
  
  #CarrierWave
  mount_uploader :image, ImageUploader #, :mount_on => :photo_file_name
  
  # #Paperclip method :large => "600x600>"
  # has_attached_file :photo, :styles => { :small => "150x150>", :medium => "300x300>", :large => "500x500>" }, # :styles Needs ImageMagick 
  #                   :storage => :s3, 
  #                   :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
  #                   :path => "/:style/:basename.:extension"
  #                   #:url => "/images/photos/:id/:style/:basename.:extension",
  #                   #:path => ":rails_root/public/images/photos/:id/:style/:basename.:extension"
  #                   
  #                   #default :url => "/:attachment/:id/:style/:basename.:extension",
  #                   #default :path => ":rails_root/public/:attachment/:id/:style/:basename.:extension"
  
  
  #SEO override of to_param for URLS
  def to_param
    "#{id}-#{full_name.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  
  #Creates Single reference for Full Name
  def full_name
    if first_name == nil || first_name == ""
      "#{email}"
    else
      "#{first_name} #{last_name}"       
    end
  end
  
  #Conditional Validation (Episode 41)
  def should_validate_password?
    updating_password || new_user
    #self.role != 'admin'
    #current_user.role == 'player'
  end
  
  
  ##TAGS
  attr_reader :tag_tokens #Getter method
  attr_accessor :tag_ids #Many to Many
  
  #Setter method to parse tag ids
  def tag_tokens=(ids)
    self.tag_ids = ids.split(",")
  end
  
  #after_save callback to handle tag_ids
   def update_tags
     unless tag_ids.nil?
       self.descriptors.each do |m|
         m.destroy unless tag_ids.include?(m.tag_id.to_s)
         tag_ids.delete(m.tag_id.to_s)
       end 
       tag_ids.each do |g|
         self.descriptors.create(:tag_id => g) unless g.blank?
       end
       reload
       self.tag_ids = nil
     end
   end
  
  
  ##ROLES
  
  SUPERROLES = %w[admin notadmin]
  
  ###This is to account for uppercase in emails, especially because Heroku and PostgreSQL are case sensitive and SQLite is not
   before_save do
     self.email.downcase! if self.email
   end

   def self.find_for_authentication(conditions) 
     conditions[:email].downcase! 
     super(conditions) 
   end
   ## END uppercase in emails fix
  
  
  
end
