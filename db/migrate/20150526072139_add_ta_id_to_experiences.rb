class AddTaIdToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :ta_id, :string
  end
end
