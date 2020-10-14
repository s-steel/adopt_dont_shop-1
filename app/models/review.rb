class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user

  validates_presence_of :title, :rating, :content

  def user_name
    User.joins(:reviews).find_by(id: user_id).name
  end
end
