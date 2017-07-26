class Api::V1::AlbumsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Album.all, adapter: :json
  end

  def show
    if Album.exists?(params[:id])
      album = Album.find(params[:id])
      render json: album, adapter: :json
    else
      render json: { error: 'Album not found' }, status: 404
    end
  end

  def create
    new_album_hash = JSON.parse(request.body.read)["album"]
    @new_album = Album.new({
      title: new_album_hash["title"],
      year_released: new_album_hash["year_released"],
      month_released: new_album_hash["month_released"]
    })
    @new_album.uploader = current_user

    unless new_album_hash.has_key? "artist_name"
      return render json: { errors: 'Must include artist name' }, status: 422
    end
    artist = Artist.find_by(name: new_album_hash["artist_name"])
    if !artist
      artist = Artist.create(name: new_album_hash["artist_name"])
      created_artist = true
    end
    @new_album.artist = artist

    if @new_album.save
      render json: @new_album
    else
      if created_artist
        artist.destroy
      end
      render json: { errors: @new_album.errors.full_messages }, status: 422
    end
  end
end
