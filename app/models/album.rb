class Album < ApplicationRecord
  belongs_to :uploader, class_name: "User", foreign_key: "uploader_id"
  belongs_to :artist

  validates :artist_id, presence: true
  validates :title, presence: true
  validates :year_released, numericality: { greater_than_or_equal_to: 1900 }, allow_nil: true
  validates :month_released, {
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 11 },
    allow_nil: true
  }
end
