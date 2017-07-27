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
    if !current_user
      return render json: { errors: ['Please sign in to submit an album'] }, status: 403
    end
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
      render json: @new_album, adapter: :json
    else
      if created_artist
        artist.destroy
      end
      render json: { errors: @new_album.errors.full_messages }, status: 422
    end
  end

  def update
    if !current_user
      return render json: { errors: ['Please sign in to edit an album'] }, status: 403
    end

    unless Album.exists?(params[:id])
      return render json: { errors: ['Album  not found'] }, status: 404
    end

    @new_album = Album.find(params[:id])
    if @new_album.uploader != current_user
      return render json: { errors: ['User is not album owner'] }, status: 403
    end

    new_album_hash = JSON.parse(request.body.read)["album"]
    unless new_album_hash.has_key? "artist_name"
      return render json: { errors: 'Must include artist name' }, status: 422
    end
    @new_album.assign_attributes({
      title: new_album_hash["title"],
      year_released: new_album_hash["year_released"],
      month_released: new_album_hash["month_released"]
    })
    if new_album_hash['artist'] != @new_album.artist.name
      artist = Artist.find_by(name: new_album_hash["artist_name"])
      if !artist
        artist = Artist.create(name: new_album_hash["artist_name"])
        created_artist = true
      end
      @new_album.artist = artist
    end

    if @new_album.save
      render json: @new_album, adapter: :json
    else
      if created_artist
        artist.destroy
      end
      render json: { errors: @new_album.errors.full_messages }, status: 422
    end
  end

  def destroy
    album = Album.find(params[:album_id])
    if current_user.admin? || current_user == album.uploader
      album.destroy
      render json: { message: `Deleted Album: ${album.title}` }, status: 204
    else
      render json: { message: 'Unauthorized to delete this album' }, status: 403
    end
  end
end
