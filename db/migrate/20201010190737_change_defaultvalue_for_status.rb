class ChangeDefaultvalueForStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :pets, :status, 'Adoptable'
  end
end
