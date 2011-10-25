class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :string
    add_column :users, :visible, :boolean, :default => false
    add_column :users, :bio, :text
    add_column :users, :title, :string
    add_column :users, :twitter, :string
    add_column :users, :website, :string
    add_column :users, :company, :string
    add_column :users, :company_website, :string
    add_column :users, :show_email, :boolean, :default => false
    add_column :users, :image, :string
    
    add_column :users, :github, :string
    add_column :users, :dribble, :string
    add_column :users, :forrst, :string
    add_column :users, :linkedin, :string
    add_column :users, :stackoverflow, :string
    
  end

  def self.down
    remove_column :users, :show_email
    remove_column :users, :website
    remove_column :users, :company
    remove_column :users, :company_website
    remove_column :users, :twitter
    remove_column :users, :title
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :role
    remove_column :users, :visible
    remove_column :users, :bio
    remove_column :users, :image
    
    remove_column :users, :github
    remove_column :users, :dribble
    remove_column :users, :forrst
    remove_column :users, :linkedin
    remove_column :users, :stackoverflow
  end
end
