class CreateDestinationPictures < ActiveRecord::Migration
  def change
    create_table :destination_pictures do |t|
      t.references :destination, index: true
      t.datetime :created_at
      t.datetime :updated_at
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at

      t.timestamps
    end
  end
end
