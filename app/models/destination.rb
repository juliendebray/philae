class Destination < ActiveRecord::Base
  has_many :recommended_trip_experiences
  has_many :recommended_trips
  has_many :experiences
  has_many :trips


  has_attached_file :picture,
    styles: {
          banner: "851x440#",
          header: "960x180#",
          small: "260x174#",
          thumb: "160x100#",
    }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

end
