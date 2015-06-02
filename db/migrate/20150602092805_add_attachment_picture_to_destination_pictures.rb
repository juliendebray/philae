class AddAttachmentPictureToDestinationPictures < ActiveRecord::Migration
  def self.up
    change_table :destination_pictures do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :destination_pictures, :picture
  end
end
