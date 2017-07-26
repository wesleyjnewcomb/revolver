class Review < ApplicationRecord

  belongs_to :user
  belongs_to :album
  has_many :votes

  validates :rating, {
    numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 },
    presence: true
  }
  validates :body, {
    length: { maximum: 30_000 }
  }
  validates :user_id, presence: true
  validates :album_id, presence: true

  def score
    sum = 0
    votes.each { |vote| sum += vote.value }
    return sum
  end
end
