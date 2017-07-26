require 'rails_helper'

RSpec.describe Api::V1::VotesController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "POST#create" do
    let!(:review) { FactoryGirl.create(:review) }
    let!(:new_vote) { FactoryGirl.create(:vote, user: @user, review: review) }
    let!(:new_vote_data) do
      {
        vote: {
          user_id: @user.id,
          review_id: review.id,
          value: new_vote.value
        }
      }.to_json
    end

    it "should create a new vote" do
      expect { post(:create, body: new_vote_data) }.to change { Vote.count }.by 1
    end

    it "should return a json of the newly created vote" do
      post(:create, body: new_vote_data)
      returned_json = JSON.parse(response.body)['vote']

      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/json'

      expect(returned_json).to be_a(Hash)
      expect(returned_json["value"]).to eq new_vote.value
      expect(returned_json["review_id"]).to eq new_vote.review_id
      expect(returned_json["user_id"]).to eq @user.id
    end
  end
end
