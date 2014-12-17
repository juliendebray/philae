class SetDefaultValueToExperiencePublishedField < ActiveRecord::Migration
  def change
    change_column_default(:experiences, :published, false)
  end
end
