class RegistrationsController < Devise::RegistrationsController
  #before_filter :authenticate_user! #Devise tip, this will make sure a user is signed in before they are allowed to access it
  #authorize_resource :class => false #CanCan tip, use ":class => false" when a controller is not backed by a method
  
  def new
     super
   end

   def create
     #params.key?(:user) == true
     
     #This is a security measure to ensure that someone does not try to force their role to be "admin" at registration
     if params[:user].key?(:role) == true
       redirect_to root_url
     end
     
     params[:user][:role] = "notadmin"
     
     super
     # add custom create logic here
   end

   def update
     super
   end
   
   
end