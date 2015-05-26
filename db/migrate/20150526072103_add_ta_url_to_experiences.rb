class AddTaUrlToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :ta_url, :string
  end
end
