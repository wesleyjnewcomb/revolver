class Api::V1::ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:album_id]
      review_models = Review.where({ album_id: params[:album_id] })
      reviews = []
      review_models.each_with_index do |review, i|
        reviews << review_models[i].serializable_hash
        reviews[i]['user'] = review_models[i].user.serializable_hash
        reviews[i]['score'] = review_models[i].score
        if current_user
          reviews[i]['signed_in'] = true
          reviews[i]['can_edit'] = (review_models[i].user == current_user || current_user.admin?)
          reviews[i]['current_user_vote'] = Vote.find_by({ review_id: review.id, user_id: current_user.id })
          reviews[i]['current_user_vote'] &&= reviews[i]['current_user_vote'].value
        else
          reviews[i]['can_edit'] = false
        end
        reviews[i]['signed_in'] ||= false
        reviews[i]['current_user_vote'] ||= 0
      end
      sorted_reviews = reviews.sort_by{ |review| review['score'] }
      
      render json: { reviews: sorted_reviews.reverse }, adapter: :json
    else
      render json: Review.all, adapter: :json
    end
  end

  def create
    if !current_user
      return render json: { errors: ['Please sign in to submit a review'] }, status: 403
    end
    new_review_hash = JSON.parse(request.body.read)["review"]
    @new_review = Review.new({
      rating: new_review_hash["rating"],
      body: new_review_hash["body"],
      album_id: new_review_hash["album_id"],
      user: current_user
    })

    if @new_review.save
      render json: @new_review, adapter: :json
    else
      render json: { errors: @new_review.errors.full_messages }, status: 422
    end
  end
end
