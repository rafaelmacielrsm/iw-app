class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name,  presence: true

  validates :email,
    presence: true, 
    uniqueness: true,
    format: { with: Devise.email_regexp }

  validates :password, presence: true

  enum role: { admin: 'admin' , member: 'member'}
end
