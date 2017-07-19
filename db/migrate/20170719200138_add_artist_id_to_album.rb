class AddArtistIdToAlbum < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :albums, :artist, null: false
  end
end
