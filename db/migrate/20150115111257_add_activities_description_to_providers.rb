class AddActivitiesDescriptionToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :activities_description, :text
  end
end
