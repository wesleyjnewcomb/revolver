class Album < ApplicationRecord
  has_many :reviews
  belongs_to :user
  belongs_to :artist
end
