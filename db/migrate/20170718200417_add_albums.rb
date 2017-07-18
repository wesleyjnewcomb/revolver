class AddAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |table|
      table.belongs_to :uploader, null: false
      table.string :title, null: false
      table.date :date_released
    end
  end
end
