class Trip < ActiveRecord::Base
  belongs_to :user

  has_many :trip_experiences
  has_many :experiences, through: :trip_experiences

  has_many :trip_comments
end
