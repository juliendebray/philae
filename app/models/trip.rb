class Trip < ActiveRecord::Base
  belongs_to :user
  belongs_to :destination

  has_many :trip_experiences
  has_many :experiences, through: :trip_experiences

  has_many :trip_comments

  has_attached_file :picture,
    styles: {
      big: "630x419#",
      medium: "280x186#",
      small: "178x118#",
    }

  validates_attachment_content_type :picture,
  content_type: /\Aimage\/.*\z/

  # geocoded_by :query
  after_validation :geocode_trip, if: :geocoding_needed?

  after_save :generate_token, if: :user_id_changed?

  def generate_url_with_token
    ROOT_URL + "/trips/#{self.id}/#{self.token}"
  end

  def set_location_lat_and_lng(results)
    self.latitude = results.latitude
    self.longitude = results.longitude
  end

  def set_country_code_if_missing(results)
    set_country_code(results) if self.country_code.nil? && results
  end

  def set_viewport_if_available(results)
    if vp = results.geometry['viewport']
      self.vp_ne_lat = vp['northeast']['lat']
      self.vp_ne_lng = vp['northeast']['lng']
      self.vp_sw_lat = vp['southwest']['lat']
      self.vp_sw_lng = vp['southwest']['lng']
    end
  end

  private
  def generate_token
    unless self.token
      random_token = SecureRandom.urlsafe_base64(nil, false)
      while Trip.where(token: random_token).any?
        random_token = SecureRandom.urlsafe_base64(nil, false)
      end
      self.token = random_token
      self.save
    end
  end

  def geocode_trip
    if results = Geocoder.search(self.query).first
      self.set_location_lat_and_lng(results)
      self.set_country_code_if_missing(results)
      self.set_viewport_if_available(results)
    end
  end

  def geocoding_needed?
    self.latitude.nil? || self.longitude.nil? || self.country_code.nil?
  end

  def set_viewport_if_missing(results)
    set_viewport_if_available(results) if viewport_missing? && results
  end

  def set_country_code(results)
    self.country_code = results.country_code
  end

  def viewport_missing?
    self.vp_ne_lat.nil? || self.vp_ne_lng.nil? || self.vp_sw_lat.nil? || self.vp_sw_lng.nil?
  end

end
