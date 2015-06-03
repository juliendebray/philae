class Destination < ActiveRecord::Base
  has_many :recommended_trip_experiences
  has_many :recommended_trips, through: :recommended_trip_experiences
  has_many :experiences

  has_many :destination_pictures, dependent: :destroy
  accepts_nested_attributes_for :destination_pictures

end
