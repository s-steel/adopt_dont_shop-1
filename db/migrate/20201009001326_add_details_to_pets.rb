class AddDetailsToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :image, :string
    add_column :pets, :name, :string
    add_column :pets, :approximate_age, :integer
    add_column :pets, :sex, :string
  end
end
