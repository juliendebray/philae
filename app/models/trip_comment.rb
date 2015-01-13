class TripComment < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode, if: :geocoding_needed?

  belongs_to :user
  belongs_to :trip

  private
  def geocoding_needed?
    if self.id
      address_changed?
    else
      self.latitude.nil? || self.longitude.nil?
    end
  end

end
