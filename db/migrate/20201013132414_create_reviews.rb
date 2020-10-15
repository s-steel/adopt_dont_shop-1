class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :rating
      t.string :content
      t.string :image
      t.references :shelter, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
