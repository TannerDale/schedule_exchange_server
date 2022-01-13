class Company < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true, on: :create

  has_many :users, dependent: :destroy
  has_many :stores, dependent: :destroy
end
