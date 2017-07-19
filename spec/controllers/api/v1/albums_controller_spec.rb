require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do

  describe "GET#index" do
    before(:each) do
      bob = create(:user, email: "anything@anything.com")
      create(:album, uploader: bob, title: "The White Album" )
      create_list(:album, 3, uploader: bob)
      create(:album, uploader: bob, title: "Dark Side of the Moon")
    end

    it "should return a list of albums with the correct length" do
      get :index
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"

      expect(returned_json.length).to eq 1
      expect(returned_json["albums"].length).to eq 5
    end

    it "should return a list of with correct album data" do
      get :index
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
      expect(returned_json.length).to eq 1

      expect(returned_json["albums"][0]["title"]).to eq "The White Album"
      expect(returned_json["albums"][4]["title"]).to eq "Dark Side of the Moon"
    end
  end

  describe "POST#create" do
    let!(:jimmy) { FactoryGirl.create(:user, email: 'me@you.com') }
    let!(:new_album) { FactoryGirl.create(:album, title: 'Round Room', uploader: jimmy) }
    let!(:invalid_album) { FactoryGirl.create(:album, uploader: jimmy) }
    let!(:invalid_album_data) { {album: { uploader_id: jimmy.id} }}
    let!(:new_album_data) { {album: {title: new_album.title, uploader_id: new_album.uploader.id}} }

    it "should create a new album" do
      expect{ post(:create, params: new_album_data) }.to change{ Album.count }.by 1
    end

    it "should return a json with the new album data" do
      post(:create, params: new_album_data)
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
      
      expect(returned_json).to be_a(Hash)
      expect(returned_json["title"]).to eq new_album.title
      expect(returned_json["uploader_id"]).to eq jimmy.id
    end

    it "should not sucessfully post an album without a title" do
      post(:create, params: invalid_album_data)
      returned_json = JSON.parse(response.body)
      expect(response.status).to eq 422
    end
  end
end
