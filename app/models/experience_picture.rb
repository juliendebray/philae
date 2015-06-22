class ExperiencePicture < ActiveRecord::Base
  belongs_to :experience

  has_attached_file :picture,
    styles: {
      banner: "851x440#",
      medium: "430x300#",
      small: "260x174#",
      thumb: "160x100#",
    }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/


end