class AddNameToExperienceReviews < ActiveRecord::Migration
  def change
    add_column :experience_reviews, :name, :string
  end
end
