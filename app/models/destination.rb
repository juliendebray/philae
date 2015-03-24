class Destination < ActiveRecord::Base
  has_many :recommended_trip_experiences
  has_many :recommended_trips, through: :recommended_trip_experiences
end
