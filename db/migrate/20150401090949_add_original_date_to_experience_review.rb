class AddOriginalDateToExperienceReview < ActiveRecord::Migration
  def change
    add_column :experience_reviews, :original_date, :string
  end
end
