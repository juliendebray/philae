class TripComment < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user
  belongs_to :trip
end
