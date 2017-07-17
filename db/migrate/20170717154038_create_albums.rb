class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.belongs_to :user
      t.belongs_to :artist
      t.string :name
      t.string :artist
      t.date :date

      t.timestamps
    end
  end
end
