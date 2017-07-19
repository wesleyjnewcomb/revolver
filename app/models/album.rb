class Album < ApplicationRecord
  belongs_to :uploader, class_name: "User", foreign_key: "uploader_id"
  belongs_to :artist

  validates :artist, presence: true
  validates :title, presence: true
end
