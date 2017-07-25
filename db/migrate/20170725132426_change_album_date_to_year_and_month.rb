class ChangeAlbumDateToYearAndMonth < ActiveRecord::Migration[5.1]
  def up
    add_column :albums, :year_released, :smallint
    add_column :albums, :month_released, :smallint

    # populate columns
    Album.all.each do |album|
      if album.date_released
        album.year_released = album.date_released.year
        album.month_released = album.date_released.month - 1
        album.save
      end
    end
    remove_column :albums, :date_released
  end

  def down
    add_column :albums, :date_released, :date

    # populate columns
    Album.all.each do |album|
      if(album.year_released && album.month_released)
        album.date_released = Date.new(album.year_released, album.month_released + 1, 1)
        album.save
      end
    end

    remove_column :albums, :year_released
    remove_column :albums, :month_released
  end
end
