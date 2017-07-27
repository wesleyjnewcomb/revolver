class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :body, :album_id, :user, :created_at, :updated_at, :score, :current_user_vote
end
