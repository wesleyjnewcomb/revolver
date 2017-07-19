require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do


  describe "GET#index" do
    before(:each) do
      @very_prolific = create(:artist)
      bob = create(:user, email: "anything@anything.com")
      create(:album, uploader: bob, title: "The White Album", artist: @very_prolific )
      create_list(:album, 3, uploader: bob, artist: @very_prolific)
      create(:album, uploader: bob, title: "Dark Side of the Moon", artist: @very_prolific)
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
      binding.pry
      expect(returned_json["albums"][0]["title"]).to eq "The White Album"
      expect(returned_json["albums"][4]["title"]).to eq "Dark Side of the Moon"
      expect(returned_json["albums"][0]["artist"]).to eq @very_prolific
      expect(returned_json["albums"][4]["artist"]).to eq @very_prolific
    end
  end

  describe "POST#create" do
    let!(:jimmy) { FactoryGirl.create(:user, email: 'me@you.com') }
    let!(:new_album) { FactoryGirl.create(:album, title: 'Round Room', artist: @very_prolific, uploader: jimmy) }
    let!(:new_album_data) { {album: {title: new_album.title, uploader_id: new_album.uploader.id}} }
    let!(:no_title_album) { FactoryGirl.create(:album, uploader: jimmy, artist: @very_prolific) }
    let!(:no_title_album_data) { {album: { uploader_id: jimmy.id, artist: @very_prolific} }}
    let!(:no_artist_album) { FactoryGirl.create(:album, uploader: jimmy, title: "the chronic 2001") }
    let!(:no_artist_album_data) { {album: { uploader_id: jimmy.id, title: "the chronic 2001"} }}

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
      expect(returned_json["artist_id"]).to eq @very_prolific.id
    end

    it "should not sucessfully post an album without a title" do
      post(:create, params: no_title_album_data)
      returned_json = JSON.parse(response.body)
      expect(response.status).to eq 422
    end

    it "should not sucessfully post an album without an artist" do
      post(:create, params: no_artist_album_data)
      returned_json = JSON.parse(response.body)
      expect(response.status).to eq 422
    end
  end
end
