class AddThousandPlacesToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :thousand_places, :boolean
  end
end
