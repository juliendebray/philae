class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :address, presence: true

  has_many :services
  has_many :providers, through: :services

  has_many :experience_reviews

  has_many :trip_experiences
  has_many :trips, through: :trip_experiences

  has_many :experience_pictures, dependent: :destroy
  accepts_nested_attributes_for :experience_pictures

  geocoded_by :address
  after_validation :geocode, if: :geocoding_needed?

  after_validation :update_published_date, if: :published_changed?

  private
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
