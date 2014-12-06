class ExperiencePicture < ActiveRecord::Base
  belongs_to :experience

  has_attached_file :picture,
    styles: {
      banner: "1400x550#",
      small: "220x170#",
      thumb: "160x100#",
    }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/


end

