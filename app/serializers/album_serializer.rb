class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :date_released, :uploader_id, :artist_id
end
