class AddAttachmentPictureToProviders < ActiveRecord::Migration
  def self.up
    change_table :providers do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :providers, :picture
  end
end
