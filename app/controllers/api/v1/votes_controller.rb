class Api::V1::VotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    new_vote_hash = JSON.parse(request.body.read)["vote"]
    @new_vote = Vote.find_or_initialize_by({
      user_id: current_user.id,
      review_id: new_vote_hash["review_id"]
    })
    @new_vote.value = new_vote_hash["value"]
    @new_vote.save

    render json: { vote: @new_vote }, adapter: :json
  end
end
