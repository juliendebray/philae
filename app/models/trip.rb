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

  geocoded_by :query
  after_validation :geocode, if: :geocoding_needed?

  after_save :generate_token, if: :user_id_changed?

  def generate_url_with_token
    ROOT_URL + "/trips/#{self.id}/#{self.token}"
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

  def geocoding_needed?
    self.latitude.nil? || self.longitude.nil?
  end
end
