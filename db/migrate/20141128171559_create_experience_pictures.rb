class CreateExperiencePictures < ActiveRecord::Migration
  def change
    create_table :experience_pictures do |t|
      t.references :experience, index: true

      t.timestamps
    end
  end
end
