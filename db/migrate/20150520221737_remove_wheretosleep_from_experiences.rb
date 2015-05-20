class RemoveWheretosleepFromExperiences < ActiveRecord::Migration
  def change
    remove_column :experiences, :wheretosleep, :text
  end
end
