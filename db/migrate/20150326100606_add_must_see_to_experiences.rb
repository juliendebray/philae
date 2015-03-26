class AddMustSeeToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :must_see, :boolean, default: false
  end
end
