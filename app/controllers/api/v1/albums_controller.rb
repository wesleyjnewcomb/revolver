class Api::V1::AlbumsController < ApplicationController

  def index
    render json: Album.all, adapter: :json
  end

  def create
    new_album = Album.create(album_params)
    # binding.pry
    # data = JSON.parse(request.body.read)
    # new_album = Album.create(title: data["title"],  uploader: data["uploader"], date_released: data["date_released"])
    render json: new_album
  end

  private

  def album_params
    params.require(:album).permit(:title, :uploader_id)
  end
end
