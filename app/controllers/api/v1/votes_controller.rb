class Api::V1::VotesController < ApplicationController
  def create
    new_vote_hash = JSON.parse(request.body.read)["vote"]
    @new_vote = Vote.find_or_initialize_by({
      user_id: current_user.id,
      review_id: new_vote_hash["review_id"],
    })
    # binding.pry
    @new_vote.value = new_vote_hash["value"]
    # binding.pry
    @new_vote.save
    # binding.pry
    # review_votes = Vote.where(review_id: params[:review_id])
    # user_votes = Vote.where(user_id: params[:user_id])
    #
    # if review_votes - user_votes == review_votes
    #   Vote.create(user_id: params[:user_id], review_id: params[:review_id], value: params[:value])
    # else
    #
    #
    render json: { vote: @new_vote }, adapter: :json
  end
end
