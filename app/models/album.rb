class Album < ApplicationRecord
  belongs_to :uploader, class_name: "User"

  validates :title, presence: true
end
