class Api::V1::AlbumsController < ApplicationController
  def index
    # binding.pry
    render json: Album.all, adapter: :json
  end

  def create
    @new_album = Album.new(album_params)
    @new_album.uploader = current_user

    if !artist_name_param
      return render json: { errors: 'Must include artist name' }, status: 422
    end

    artist = Artist.find_by(name: artist_name_param)
    if !artist
      artist = Artist.create(name: artist_name_param)
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

  private
  def artist_name_param
    artist_name = params[:album][:artist_name]
    unless artist_name.nil?
      artist_name.strip!
    end
    artist_name
  end

  def album_params
    params.require(:album).permit(:title, :uploader_id, :date_released)
  end
end
