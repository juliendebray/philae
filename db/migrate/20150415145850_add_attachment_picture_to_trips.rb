class AddAttachmentPictureToTrips < ActiveRecord::Migration
  def self.up
    change_table :trips do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :trips, :picture
  end
end
