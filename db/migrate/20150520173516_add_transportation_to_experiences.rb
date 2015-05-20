class AddTransportationToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :transportation, :text
  end
end
