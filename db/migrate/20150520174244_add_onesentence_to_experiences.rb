class AddOnesentenceToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :onesentence, :text
  end
end
