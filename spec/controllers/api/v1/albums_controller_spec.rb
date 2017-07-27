require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do
  describe "GET#index" do
    before(:each) do
      @very_prolific = create(:artist)
      @bob = FactoryGirl.create(:user, email: "anything@anything.com")
      sign_in @bob
      create(:album, uploader: @bob, title: "The White Album", artist: @very_prolific )
      create_list(:album, 3, uploader: @bob, artist: @very_prolific)
      create(:album, uploader: @bob, title: "Dark Side of the Moon", artist: @very_prolific)
    end

    after(:each) do
      sign_out @bob
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
        expect(returned_json["album"]["title"]).to eq new_album.title
        expect(returned_json["album"]["uploader_id"]).to eq @user.id
        expect(returned_json["album"]["artist"]["id"]).to eq @very_prolific.id
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
        expect(returned_json["album"]["title"]).to eq new_album.title
        expect(returned_json["album"]["uploader_id"]).to eq @user.id

        new_artist = Artist.find(returned_json["album"]["artist"]["id"])
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

  describe "PATCH#update" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    let!(:album) { FactoryGirl.create(:album, uploader: @user)}
    context 'correct data in request' do
      let!(:new_album_data) do
        {
          album: {
            title: 'Revolver',
            artist_name: 'The Beatles',
            month_released: '',
            year_released: 1965
          }
        }.to_json
      end
      it 'should update an existing album with the provided data' do
        id = album.id
        patch(:update, params: { id: id }, body: new_album_data)
        returned_json = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'

        expect(returned_json).to be_a(Hash)
        expect(returned_json['album']["title"]).to eq 'Revolver'
        expect(returned_json['album']['year_released']).to eq 1965
        expect(returned_json['album']["artist"]["name"]).to eq 'The Beatles'

        album = Album.find(id)
        expect(album.title).to eq 'Revolver'
        expect(album.artist.name).to eq 'The Beatles'
        expect(album.year_released).to eq 1965
      end
    end

    context 'incorrect data in request' do
      it 'should not update if the title is not provided' do
        no_title_data = {
          album: {
            artist_name: 'The Beatles',
            month_released: 7,
            year_released: 1965
          }
        }.to_json
        id = album.id
        patch(:update, params: { id: id }, body: no_title_data)
        expect(response.status).to eq 422
      end

      it 'should not update if the artist is not provided' do
        no_artist_data = {
          album: {
            title: 'Revolver',
            month_released: 7,
            year_released: 1965
          }
        }.to_json
        id = album.id
        patch(:update, params: { id: id }, body: no_artist_data)
        expect(response.status).to eq 422
      end
    end

    context 'invalid user session' do
      let!(:new_album_data) do
        {
          album: {
            title: 'Revolver',
            artist_name: 'The Beatles',
            month_released: '',
            year_released: 1965
          }
        }.to_json
      end
      it 'should not update if the user is not logged in' do
        sign_out @user

        id = album.id
        patch(:update, params: { id: id }, body: new_album_data)
        returned_json = JSON.parse(response.body)

        expect(response.status).to eq 403
      end

      it 'should not update if the user is not the creator of the album' do
        album = FactoryGirl.create(:album)
        patch(:update, params: { id: album.id }, body: new_album_data)
        returned_json = JSON.parse(response.body)

        expect(response.status).to eq 403
      end
    end
  end

  describe "DELETE#destroy" do

    context "album successfully deleted by admin" do

      before(:each) do
        @admin = FactoryGirl.create(:user, role: "admin")
        sign_in @admin
        @album = FactoryGirl.create(:album)
        @album_2 = FactoryGirl.create(:album)
        @reviews = FactoryGirl.create_list(:review, 3, album: @album)
        @reviews_2 = FactoryGirl.create_list(:review, 2, album: @album_2)
      end

      it "should return a json confirming the deletion" do
        delete :destroy, params: { id: @album.id }
        returned_json = JSON.parse(response.body)
        # binding.pry
        expect(response.status).to eq 204
        # expect(response.content_type).to eq 'application/json'
        expect(returned_json["message"]).to include("Deleted Album:")
      end

      it "should remove the album from the database" do
        delete(:destroy, params: { id: @album.id })
        expect(Album.all).to_not include(@album)
      end

      it "should only destroy the intended album" do
        delete(:destroy, params: { id: @album.id })
        expect(Album.all).to include(@album_2)
      end

      it "should remove the deleted album's reviews from the database" do
        delete(:destroy, params: { id: @album.id })
        @reviews.each do |review|
          expect(Review.all).to_not include(review)
        end
      end

      it "should not destroy any other reviews" do
        delete(:destroy, params: { id: @album.id })
        @reviews_2.each do |review|
          expect(Review.all).to include(review)
        end
      end
    end

    context "album successfully deleted by uploader" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
        @album = FactoryGirl.create(:album, uploader: @user)
        @album_2 = FactoryGirl.create(:album)
        @reviews = FactoryGirl.create_list(:review, 3, album: @album)
        @reviews_2 = FactoryGirl.create_list(:review, 2, album: @album_2)
      end

      it "should return a json confirming the deletion" do
        delete :destroy, params: { id: @album.id }
        returned_json = JSON.parse(response.body)
        expect(response.status).to eq 204
        expect(returned_json["message"]).to include("Deleted Album:")
      end

      it "should remove the album from the database" do
        delete(:destroy, params: { id: @album.id })
        expect(Album.all).to_not include(@album)
      end

      it "should only destroy the intended album" do
        delete(:destroy, params: { id: @album.id })
        expect(Album.all).to include(@album_2)
      end

      it "should remove the deleted album's reviews from the database" do
        delete(:destroy, params: { id: @album.id })
        @reviews.each do |review|
          expect(Review.all).to_not include(review)
        end
      end

      it "should not destroy any other reviews" do
        delete(:destroy, params: { id: @album.id })
        @reviews_2.each do |review|
          expect(Review.all).to include(review)
        end
      end
    end

    context "non-admin user tries to delete an album they didn't upload" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        @user_2 = FactoryGirl.create(:user)
        sign_in @user
        @album = FactoryGirl.create(:album, uploader: @user_2)
      end

      it "should not remove any albums from the database" do
        expect{ delete(:destroy, params: { id: @album.id }) }.to change{ Album.count }.by 0
      end

      it "should return a json indicating the unsuccesful deletion" do
        delete :destroy, params: { id: @album.id }
        returned_json = JSON.parse(response.body)
        expect(response.status).to eq 403
        expect(returned_json["message"]).to include("Unauthorized")
      end
    end

    context "unauthenticated user tries to delete an album" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        @album = FactoryGirl.create(:album, uploader: @user)
      end

      it "should not remove any albums from the database" do
        expect{ delete(:destroy, params: { id: @album.id }) }.to change{ Album.count }.by 0
      end

      it "should return a json indicating the unsuccesful deletion" do
        delete :destroy, params: { id: @album.id }
        returned_json = JSON.parse(response.body)
        expect(response.status).to eq 403
        expect(returned_json["message"]).to include("Unauthorized")
      end
    end

  end
end
