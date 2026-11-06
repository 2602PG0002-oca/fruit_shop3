class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :trackable, :rememberable, :validatable

  has_many :orders
  has_one :cart
end