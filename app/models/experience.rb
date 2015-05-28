class Experience < ActiveRecord::Base
  serialize :category_tab, Array

  belongs_to :user
  belongs_to :category
  belongs_to :trip_comment
  belongs_to :destination

  has_many :services
  has_many :providers, through: :services

  has_many :experience_reviews
  has_many :leader_reviews

  has_many :trip_experiences
  has_many :trips, through: :trip_experiences

  has_many :recommended_trip_experiences
  has_many :recommended_trips, through: :recommended_trip_experiences

  has_many :experience_pictures, dependent: :destroy
  accepts_nested_attributes_for :experience_pictures

  geocoded_by :address
  after_validation :geocode, if: :geocoding_needed?
  after_validation :set_country_code, if: :country_code_needed?

  after_validation :update_published_date, if: :published_changed?

  private
  def country_code_needed?
    self.country_code.nil?
  end

  def set_country_code
    if results = Geocoder.search([self.latitude, self.longitude]).first
      self.country_code = results.country_code
    end
  end

  def update_published_date
    self.published_at = DateTime.now
  end

  def geocoding_needed?
    if self.id
      address_changed?
    else
      self.latitude.nil? || self.longitude.nil?
    end
  end
end
