class AddTransportationToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :transportation, :string
  end
end
