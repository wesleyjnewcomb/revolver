class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :year_released, :month_released, :uploader_id, :artist
end
