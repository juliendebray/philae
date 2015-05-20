class RemoveWheretosleepFromExperiences < ActiveRecord::Migration
  def change
    remove_column :experiences, :wheretosleep, :string
  end
end
