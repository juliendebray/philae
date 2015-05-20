class AddOnesentenceToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :onesentence, :string
  end
end
