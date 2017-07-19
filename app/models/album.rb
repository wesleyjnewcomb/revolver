class Album < ApplicationRecord
  belongs_to :uploader, class_name: "User", foreign_key: "uploader_id"

  validates :title, presence: true
end
