class Api::V1::AlbumsController < ApplicationController
  def index
    # binding.pry
    render json: Album.all, adapter: :json
  end

  def create
    @new_album = Album.new(album_params)
    if @new_album.save
      render json: @new_album
    else
      render json: { errors: @new_album.errors.full_messages }, status: 422
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :artist_id, :uploader_id, :date_released)
  end
end
