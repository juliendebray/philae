class DestinationPicture < ActiveRecord::Base
  belongs_to :destination

  has_attached_file :picture,
    styles: {
      banner: "851x440#",
      medium: "430x223#",
      small: "260x174#",
      thumb: "160x100#",
      flat: "851x220#",
    }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

end
