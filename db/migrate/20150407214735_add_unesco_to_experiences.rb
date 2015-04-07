class AddUnescoToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :unesco, :boolean
  end
end
