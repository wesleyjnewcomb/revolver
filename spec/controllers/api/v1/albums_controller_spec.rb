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

    it "should render a list of albums with the correct length" do
      get :index
      returned_json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"

      expect(returned_json.length).to eq 1
      expect(returned_json["albums"].length).to eq 5
    end

    it "should render a list of with correct album data" do
      get :index
      returned_json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
      expect(returned_json.length).to eq 1

      expect(returned_json["albums"][0]["title"]).to eq "The White Album"
      expect(returned_json["albums"][4]["title"]).to eq "Dark Side of the Moon"
      expect(returned_json["albums"][0]["artist"]["id"]).to eq @very_prolific.id
      expect(returned_json["albums"][4]["artist"]["id"]).to eq @very_prolific.id
    end
  end

  describe 'GET#show' do
    let!(:album) { FactoryGirl.create(:album) }
    it 'should render a json representing the correct album' do
      get :show, params: { id: album.id }
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
      expect(returned_json).to be_a Hash

      expect(returned_json["album"]["id"]).to eq album.id
      expect(returned_json["album"]["title"]).to eq album.title
      expect(returned_json["album"]["artist"]["id"]).to eq album.artist.id
    end

    it 'should respond with 404 if the album is not found' do
      get :show, params: { id: 1 }
      expect(response.status).to eq 404
    end
  end

  describe "POST#create" do
    before(:each) do
      @very_prolific = FactoryGirl.create(:artist)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    let!(:new_album) do
      FactoryGirl.create(:album,
        title: 'Round Room',
        artist: @very_prolific,
        uploader: @user
      )
    end

    context 'artist exists in database' do
      let!(:new_album_data) do
        {
          album: {
            title: new_album.title,
            artist_name: @very_prolific.name
          }
        }.to_json
      end

      it "should create a new album" do
        expect{ post(:create, body: new_album_data) }.to change { Album.count }.by 1
      end

      it 'should return a json of the newly created album' do
        post(:create, body: new_album_data)
        returned_json = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(response.content_type).to eq "application/json"

        expect(returned_json).to be_a(Hash)
        expect(returned_json["title"]).to eq new_album.title
        expect(returned_json["uploader_id"]).to eq @user.id
        expect(returned_json["artist"]["id"]).to eq @very_prolific.id
      end
    end

    context 'artist does not exist in database' do
      let!(:new_artist_album_data) do
        {
          album: {
            title: new_album.title,
            artist_name: 'Eric Clapton'
          }
        }.to_json
      end

      it "should create a new album" do
        expect { post(:create, body: new_artist_album_data) }.to change { Album.count }.by 1
      end

      it 'should return a json of the newly created album' do
        post(:create, body: new_artist_album_data)
        returned_json = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(response.content_type).to eq "application/json"

        expect(returned_json).to be_a(Hash)
        expect(returned_json["title"]).to eq new_album.title
        expect(returned_json["uploader_id"]).to eq @user.id

        new_artist = Artist.find(returned_json["artist"]["id"])
        expect(new_artist.name).to eq 'Eric Clapton'
      end
    end

    context 'request does not have correct data' do
      let!(:no_artist_album_data) do
        {
          album: {
            title: new_album.title
          }
        }.to_json
      end

      let!(:no_title_album_data) do
        {
          album: {
            artist_name: 'The Beatles',
            title: ' '
          }
        }.to_json
      end
      it "should not sucessfully post an album without an artist name" do
        post(:create, body: no_artist_album_data)
        expect(response.status).to eq 422
      end

      it 'should not successfully post an album without a title' do
        post(:create, body: no_title_album_data)
        expect(response.status).to eq 422
      end
    end
  end
end
