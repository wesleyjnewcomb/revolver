class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :body
      t.belongs_to :album, null: false
      t.belongs_to :user, null: false
      
      t.timestamps
    end
  end
end
