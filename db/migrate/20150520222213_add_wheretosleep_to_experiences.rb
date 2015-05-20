class AddWheretosleepToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :wheretosleep, :text
  end
end
