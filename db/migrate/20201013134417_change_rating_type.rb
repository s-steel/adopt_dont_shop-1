class ChangeRatingType < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :rating
    add_column :reviews, :rating, :integer
  end
end
