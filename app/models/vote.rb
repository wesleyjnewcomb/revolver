class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :value, presence: true
  validates :value, numericality: { only_integer: true }
  validates_inclusion_of :value, in: -1..1
  validates :user_id, presence: true
  validates :review_id, presence: true
end
