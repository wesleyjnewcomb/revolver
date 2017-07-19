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
    let!(:new_album_data) { {album: {title: new_album.title, uploader_id: new_album.uploader.id}} }

    it "should create a new album" do
      # post '/api/v1/albums', params: { "title" => new_album.title, "uploader_id" => new_album.uploader.id  }
      # binding.pry
      # new_album_data
      expect{ post(:create, params: new_album_data) }.to change{ Album.count }.by 1
    end


  end
end
