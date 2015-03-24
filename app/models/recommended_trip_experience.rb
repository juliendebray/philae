class RecommendedTripExperience < ActiveRecord::Base
  belongs_to :recommended_trip
  belongs_to :experience

  has_attached_file :picture,
    styles: {
          banner: "851x440#",
          small: "260x174#",
          thumb: "160x100#",
    }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/
end
