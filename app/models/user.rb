class User < ApplicationRecord
  has_many :orders
  validates_presence_of :first_name, :last_name, :address, :password
  validates :username, presence: true, uniqueness: true
  enum role: [:default, :admin]
  has_secure_password
end
