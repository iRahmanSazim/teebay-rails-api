class User < ApplicationRecord
  has_many :products, dependent: :delete_all
  
  validates :user_name, presence: true
  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
