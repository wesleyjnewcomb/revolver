class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :body, :album_id, :user_id, :created_at, :updated_at
end
