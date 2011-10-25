class Ability
  include CanCan::Ability

  def initialize(user)
   user ||= User.new # guest user
    
       if user.role == "admin" # || user.role == "dj"
          can :manage, :all
       elsif user.role == "notadmin"
          can :read, User
          can :read, Tag
          can :manage, Descriptor
          can [:edit, :update], User do |u|
            u.try(:id) == user.id #This ensures that a user with role not "admin" can only edit their own profile
          end
       else
         can :read, User #Guest users can see the index and show pages of all controllers
       end
     
   end
   
end
