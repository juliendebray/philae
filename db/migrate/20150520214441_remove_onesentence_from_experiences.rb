class RemoveOnesentenceFromExperiences < ActiveRecord::Migration
  def change
    remove_column :experiences, :onesentence, :string
  end
end
