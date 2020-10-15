class ChangeDefaultValueForReviewsImage < ActiveRecord::Migration[5.2]
  def change
    change_column_null :reviews, :image, true
  end
end
