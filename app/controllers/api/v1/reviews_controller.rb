class Api::V1::ReviewsController < ApplicationController
  def index
    if params[:album_id]
      review_models = Review.where({ album_id: params[:album_id] })
      reviews = []
      review_models.each_with_index do |review, i|
        reviews << review_models[i].serializable_hash
        reviews[i]['username'] = review_models[i].user.username
        reviews[i]['user_email'] = review_models[i].user.email
      end
      render json: { reviews: reviews }, adapter: :json
    else
      render json: Review.all, adapter: :json
    end
  end

  def create
    new_review_hash = JSON.parse(request.body.read)["review"]
    @new_review = Review.new({
      rating: new_review_hash["rating"],
      body: new_review_hash["body"],
      album_id: new_review_hash["album_id"],
      user_id: current_user.id
    })

    if @new_review.save
      render json: @new_review, adapter: :json
    else
      render json: { errors: @new_review.errors.full_messages }, status: 422
    end
  end
end
