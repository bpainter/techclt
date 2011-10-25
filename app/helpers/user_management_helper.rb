module UserManagementHelper
  
  def was_invited_by(user_id)
    
    if User.exists?(:id => user_id)
      invited_by = User.find(user_id).full_name
      return invited_by
    else
      return "Inviter Removed"
    end
    
  end
  
end
