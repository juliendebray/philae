class AddWheretosleepToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :wheretosleep, :string
  end
end
