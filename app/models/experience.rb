class Experience < ActiveRecord::Base
  belongs_to :user

  has_many :services
  has_many :providers, through: :services

  has_many :experience_reviews

  has_many :trip_experiences
  has_many :trips , through: :trip_experiences

end
