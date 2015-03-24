class AddAttachmentPictureToDestinations < ActiveRecord::Migration
  def self.up
    change_table :destinations do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :destinations, :picture
  end
end
