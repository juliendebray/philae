class RecommendedTripExperience < ActiveRecord::Base
  belongs_to :recommended_trip
  belongs_to :experience
end
