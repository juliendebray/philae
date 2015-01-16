class Provider < ActiveRecord::Base
  has_many :services
  has_many :experiences, through: :services

  has_attached_file :picture,
      styles: {
        thumb: "100x100#"
      }

    validates_attachment_content_type :picture,
      content_type: /\Aimage\/.*\z/
end
