class Api::V1::AlbumsController < ApplicationController

  def index
    render json: Album.all, adapter: :json
  end

  def create
    data = JSON.parse(request.body.read)
    new_album = Album.create(title: data["title"],  uploader: data["uploader"], date_released: data["date_released"])
    render json: new_album, adapter: :json
  end
end
