class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_accessor :login

  # https://web-crunch.com/posts/devise-login-with-username-email
  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).find_by('lower(username) = :value OR lower(email) = :value', value: login.strip.downcase)
  end
end
