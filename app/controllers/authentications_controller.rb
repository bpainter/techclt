class AuthenticationsController < ApplicationController
  #This was generated with Ryanb's nifty-generators
  # rails g nifty:scaffold authentication user_id:integer provider:string uid:string index create destroy
  
  def index
    @authentications = current_user.authentications if current_user #Authentication.all
  end
  
  def create  
    omniauthhash = request.env["omniauth.auth"] 
    authentication = Authentication.find_by_provider_and_uid(omniauthhash['provider'], omniauthhash['uid'])
     
        if authentication
          puts "Thinks it was a success"
          flash[:notice] = "Signed in successfully."
          sign_in_and_redirect(:user, authentication.user) #Omniauth method
        elsif current_user 
          puts "Current User"
          current_user.authentications.create!(:provider => omniauthhash['provider'], :uid => omniauthhash['uid'])
          flash[:notice] = "Authentication successful."
          redirect_to current_user_path
        else
          puts "New User"
          user = User.new
          user.apply_omniauth(omniauthhash) #Found in the user model
          if user.save
            flash[:notice] = "Signed in successfully."
            sign_in_and_redirect(:user, user) #Omniauth method
          else
            session[:omniauthhash] = omniauthhash.except('extra') #This saves the hash to a session cookie without the 'extra' piece of the API return
            redirect_to new_user_registration_url
          end
        end
    
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id]) #Authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
