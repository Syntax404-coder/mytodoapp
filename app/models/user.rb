class User < ApplicationRecord
  has_secure_password
  has_many :reservations, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  enum :role, { customer: 0, admin: 1 }
end
