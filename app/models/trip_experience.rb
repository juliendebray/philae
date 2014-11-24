class TripExperience < ActiveRecord::Base
  belongs_to :trip
  belongs_to :experience
end
