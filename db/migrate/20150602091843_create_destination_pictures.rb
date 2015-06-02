class CreateDestinationPictures < ActiveRecord::Migration
  def change
    create_table :destination_pictures do |t|
      t.references :destination, index: true
      t.timestamps
    end
  end
end
