class Trip < ActiveRecord::Base
  belongs_to :user

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

  before_save :geocode_trip, if: :geocoding_needed?
  before_save :generate_token, if: :user_id_changed?

  def generate_url_with_token
    ROOT_URL + "/trips/#{self.id}/#{self.token}"
  end

  def set_location_lat_and_lng(results)
    self.latitude = results.latitude
    self.longitude = results.longitude
  end

  def set_country_code(results)
    self.country_code = results.country_code
  end

  def viewport_set?
    self.vp_ne_lat && self.vp_ne_lng && self.vp_sw_lat && self.vp_sw_lng ? true : false
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
      self.set_country_code(results)
      self.set_viewport_if_available(results)
    end
  end

  def geocoding_needed?
    if self.latitude.nil? || self.longitude.nil? || self.country_code.nil?
      return true
    elsif self.latitude == '' || self.longitude == '' || self.country_code == ''
      return true
    else
      return false
    end
  end
end
