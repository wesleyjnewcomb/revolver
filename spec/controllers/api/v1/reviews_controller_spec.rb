require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  describe "GET#index" do
    let!(:album) { FactoryGirl.create(:album) }
    let!(:reviews) { FactoryGirl.create_list(:review, 5, album: album ) }
    let!(:other_review) { FactoryGirl.create(:review) }

    it 'should return an array of reviews of the correct length' do
      get :index, params: { album_id: album.id }
      returned_json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/json'

      expect(returned_json['reviews'].length).to eq 5
    end

    it 'should only return the reviews for a single album' do
      get :index, params: { album_id: album.id }
      returned_json = JSON.parse(response.body)

      reviews.each_with_index do |review, index|
        expect(returned_json['reviews'][index]['id']).to eq review[:id]
      end
    end
  end

  describe "POST#Create" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    let!(:new_review) { FactoryGirl.create(:review) }

    context 'correct data' do
      let!(:new_review_data) do
        {
          review: {
            album_id: new_review.album.id,
            rating: new_review.rating,
            body: new_review.body
          }
        }.to_json
      end

      it "should create a new review" do
        expect { post(:create, body: new_review_data) }.to change { Review.count }.by 1
      end

      it "should return a json of the newly create review" do
        post(:create, body: new_review_data)
        returned_json = JSON.parse(response.body)['review']

        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'

        expect(returned_json).to be_a(Hash)
        expect(returned_json["rating"]).to eq new_review.rating
        expect(returned_json["body"]).to eq new_review.body
        expect(returned_json["album_id"]).to eq new_review.album_id
        expect(returned_json["user_id"]).to eq @user.id
      end
    end

    context 'incorrect data' do
      let!(:no_rating_data) do
        {
          review: {
            album_id: new_review.album.id,
            body: new_review.body
          }
        }.to_json
      end

      let!(:no_album_data) do
        {
          review: {
            rating: new_review.rating,
            body: new_review.body
          }
        }.to_json
      end

      it 'should not sucessfully post an album without a rating' do
        post(:create, body: no_rating_data)
        expect(response.status).to eq 422
      end

      it 'should not sucessfully post an album without a album_id' do
        post(:create, body: no_album_data)
        expect(response.status).to eq 422
      end
    end
  end
end
