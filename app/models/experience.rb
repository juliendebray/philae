class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :services
  has_many :providers, through: :services

  has_many :experience_reviews

  has_many :trip_experiences
  has_many :trips , through: :trip_experiences

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
