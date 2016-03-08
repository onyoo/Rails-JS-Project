# Manages users authorization
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.member_status == "Little Grasshopper"
      can :create, [Category, Subject, Resource]
    elsif user.member_status == "Legend"
      can :create, [Category, Subject, Resource]
      can :edit, [Category, Subject, Resource]
    elsif user.member_status == "Grand Master"
      can :create, [Category, Subject, Resource]
      can :edit, [Category, Subject, Resource]
      can :delete, [Category, Subject, Resource]
    end

  end
end
