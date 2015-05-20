class AddLandingPointToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :landing_point, :boolean, default: false
  end
end
