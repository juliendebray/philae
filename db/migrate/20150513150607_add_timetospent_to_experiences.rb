class AddTimetospentToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :timetospent, :string
  end
end
