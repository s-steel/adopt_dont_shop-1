class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user

  validates_presence_of :title, :rating, :content

  def user_name
    self.user.name
  end
end
