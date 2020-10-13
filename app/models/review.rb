class Review < ApplicationRecord
  belongs_to :shelter 
  belongs_to :user

  def user_name
    User.joins(:reviews).find_by(id: user_id).name
  end
end
