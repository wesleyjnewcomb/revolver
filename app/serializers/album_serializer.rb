class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :uploader_id
end
