class User < ApplicationRecord
  has_many :albums
  has_many :reviews

  validates :username, presence: true, length: { in: 3..20 }
  validates :email, presence: true, length: { in: 5..30 }
end
