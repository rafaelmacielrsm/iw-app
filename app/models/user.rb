class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name,  presence: true

  validates :email,
    presence: true, 
    uniqueness: { case_sensitive: false },
    format: { with: Devise.email_regexp }

  validates :password, presence: true

  validates :height, presence: true, numericality: { only_integer: true }

  enum role: { admin: 'admin' , member: 'member' }
end
