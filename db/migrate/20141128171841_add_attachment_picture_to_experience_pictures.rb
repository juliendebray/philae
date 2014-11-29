class AddAttachmentPictureToExperiencePictures < ActiveRecord::Migration
  def self.up
    change_table :experience_pictures do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :experience_pictures, :picture
  end
end
