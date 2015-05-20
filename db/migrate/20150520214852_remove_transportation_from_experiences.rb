class RemoveTransportationFromExperiences < ActiveRecord::Migration
  def change
    remove_column :experiences, :transportation, :string
  end
end
