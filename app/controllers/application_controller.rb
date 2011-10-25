class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :adjust_format_for_mobilesafari
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied"
    redirect_to root_url
  end
  
  #Devise, This redirects the User to their profile page after logging in.
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User) 
      #user_path(resource_or_scope)  #super
      #current_user_edit_path
      edit_user_path(current_user)
    else
      #flash[:notice] = "Successful! Want to invite someone else?"
      new_user_invitation_path
    end
  end
  
  private

    def is_mobile?
      #request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(iPhone|iPod)/]
    end

    def adjust_format_for_mobilesafari

      #if request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(iPad|Android)/]
          #puts "TechCLT Mobile YOOOOOOWWW"

        if is_mobile?
            request.format = :mobile
        end
      
      # if Rails.env.production? && request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(iPad)/]
      #    request.format = :ipad 
      # elsif request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(iPhone|iPod)/]
      #    request.format = :iphone
      # if request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
      #   request.format = :mobile
      # end
    end
  
  
end
