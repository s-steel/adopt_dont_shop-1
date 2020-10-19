class CreateUserApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :user_applications do |t|
      t.string :description
      t.string :status
      t.references :user, foreign_key: true
    end
  end
end
