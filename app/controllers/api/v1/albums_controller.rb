class Api::V1::AlbumsController < ApplicationController

  def index
    render json: Album.all, adapter: :json
  end
end
