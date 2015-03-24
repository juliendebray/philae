class RecommendedTrip < ActiveRecord::Base
  has_many :recommended_trip_experiences
  has_many :destinations, through: :recommended_trip_experiences
end
