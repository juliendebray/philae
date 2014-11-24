class CreateExperienceReviews < ActiveRecord::Migration
  def change
    create_table :experience_reviews do |t|
      t.references :experience, index: true
      t.text :comment
      t.float :rating
      t.references :user, index: true

      t.timestamps
    end
  end
end
