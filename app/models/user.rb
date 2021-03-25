class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :username, presence: true,
                       uniqueness: true,
                       format: { with: /\A[a-z0-9]+\z/, message: 'Only allow lower-case letters and numbers.' }
                       exclusion: { in: %w(about admin) }
  validate :restricted_usernames_from_routes

  attr_accessor :login

  # https://web-crunch.com/posts/devise-login-with-username-email
  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).find_by('lower(username) = :value OR lower(email) = :value', value: login.strip.downcase)
  end

  private

  def restricted_usernames_from_routes
    list = Rails.application.routes.routes.map do |r|
      r.path.spec.to_s.split('/')[1]&.delete_suffix('(.:format)')
    end.uniq.compact
    # NOTE: can combine with a yaml file that list restricted usernames => it's better
    # https://gist.github.com/theskumar/54be20713e53d418bf02

    errors.add(:username, message: 'is already in use. Please use a different username.') if list.include? username
  end
end
