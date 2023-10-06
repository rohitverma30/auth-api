class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :companies

  ROLES = %w{super_admin admin manager editor collaborater} # by using this array we make roles to user modele


   def jwt_payload
    super
  end

  ROLES.each do |role_name| # by using this loop we define everey role in it
    define_method "#{role_name}?"do
      role == role_name
    end
  end
  #def super_admin? # we used ? here to get boolean value
    #role == 'super_admin'
 # end

end
