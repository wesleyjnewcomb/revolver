class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :body, :album_id, :user, :created_at, :updated_at, :score
end
