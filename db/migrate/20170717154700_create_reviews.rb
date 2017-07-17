class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.belongs_to :album

      t.string :body
      t.integer :rating

      t.timestamps
    end
  end
end
