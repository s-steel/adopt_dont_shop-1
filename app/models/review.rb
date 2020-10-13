class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user

  #validates :name, inclusion: { in: User.all}

  def user_name
    User.joins(:reviews).find_by(id: user_id).name
  end
end
