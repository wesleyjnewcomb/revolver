class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :uploader_id, :artist_id
end
