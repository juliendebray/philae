class AddAttachmentPictureToRecommendedTrips < ActiveRecord::Migration
  def self.up
    change_table :recommended_trips do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :recommended_trips, :picture
  end
end
