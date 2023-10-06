# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
   if user.super_admin? || user.email == 'rv790562@gmail.com'
     can :manage, :all
   elsif user.admin?
     #can :read, Company, user_id: user.id
     #can :update, Company, user_id: user.id
     can [:update,:read], Company, user:user #it also work with user:user and we pass this in array
   end
  end
end
