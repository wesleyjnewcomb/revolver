class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.belongs_to :album
      t.string :name

      t.timestamps
    end
  end
end
