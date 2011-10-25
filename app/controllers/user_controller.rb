class UserController < ApplicationController
  load_and_authorize_resource #, :except[:index, :show]
    
  def index
    #@users = User.all #.excludes(:id => current_user.id)
    
    #response.headers['Cache-Control'] = 'public, max-age=300'
    
    if is_mobile?
      #@users = User.all(:conditions => ['visible = ? AND id = ?', true, 1], :order => 'id DESC')
      @users = User.all(:conditions => ['visible = ?', true], :order => 'id DESC')
    else
      @users = User.paginate :per_page => 6, :page => params[:page], :conditions => ['visible = ?', true], # :conditions => ['id = ?', "#{}"], 
             :order => 'id DESC' #'random()' #
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @users }
    end
    
  end
  
  def new
    @user = User.new
    @user.new_user = true #virtual attribute
  end
  
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def create
    
    @user = User.new(params[:user])
    # puts "User has an image"
    # puts @user.image?
   
    if @user.save  
      
      if @user.first_name? && @user.last_name? && @user.image? && @user.bio? && @user.tags.count != 0 && !@user.visible?
        @user.update_attribute(:visible, true)
        flash[:notice] = "Successfully created User."
        redirect_to :controller => 'user', :action => 'show'
      else
        flash[:notice] = "Your profile is not visible until you update your Name, Tags, Bio, and Photo."
        render :action => 'edit'
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    # puts "User has an image"
    # puts @user.image?
    
    @user.updating_password = true if !params[:user][:password].blank? #Conditional Validation for updating a password
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    
    #Remove http if someone puts it in.
    txt='http://www.stuff.com'

    #http = '(https?://)'
    if !params[:user][:website].blank?
      temp_website = params[:user][:website]
      params[:user][:website] = temp_website.gsub(/http[s]?:\/\//,"")
      puts params[:user][:website]
    end
    
    if !params[:user][:company_website].blank?
      temp_website = params[:user][:company_website]
      params[:user][:company_website] = temp_website.gsub(/http[s]?:\/\//,"")
      puts params[:user][:company_website]
    end 

    # re1='(http)'  # Word 1
    # re2='(:)' # Any Single Character 1
    # re3='(\\/)' # Any Single Character 2
    # re4='(\\/)' # Any Single Character 3

    #re=(re1+re2+re3+re4)
    # m=Regexp.new(http,Regexp::IGNORECASE);
    # if m.match(txt)
    #     word1=m.match(txt)[1];
    #     c1=m.match(txt)[2];
    #     c2=m.match(txt)[3];
    #     c3=m.match(txt)[4];
    #     puts "("<<word1<<")"<<"("<<c1<<")"<<"("<<c2<<")"<<"("<<c3<<")"<< "\n"
    # end
  
    
    if @user.update_attributes(params[:user])
      
      if params[:user].key?(:visible) && params[:user][:visible] == "0"
        flash[:notice] = "Profile is not visible."
        render :action => 'edit'
      elsif @user.first_name? && @user.last_name? && @user.image? && @user.bio? && @user.tags.count != 0 && !@user.visible?
        @user.update_attribute(:visible, true)
        flash[:notice] = "Successfully updated User."
        redirect_to :controller => 'user', :action => 'show'
      else
        flash[:notice] = "Your profile is not visible until you update your Name, Tags, Bio, and Photo."
        render :action => 'edit'
      end
      
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    #OMNIAUTH @authentications = Authentication.delete_all(:user_id => params[:id])  #Gertig, also destroy all Authentication records with this user_id.
    #puts "Authentication Destroy"
    #to_id(params[:id])
    # seo_id = params[:id]
    # puts "Chompage"
    # #puts seo_id.match(/[^0-9]/)[0]
    # 
    # re1='(\\d+)'  # Integer Number 1
    # 
    # re=(re1)
    # m=Regexp.new(re,Regexp::IGNORECASE);
    # if m.match(seo_id)
    #     int1=m.match(seo_id)[1];
    #     puts int1
    # end

    
    #puts seo_id.chomp!('-')
    
    @user = User.find(params[:id])
    if @user.destroy
      #puts "User Destroy"
      flash[:notice] = "Successfully deleted User."
      redirect_to :controller => 'user_management', :action => 'index' # root_path
    end
  end
  

end
