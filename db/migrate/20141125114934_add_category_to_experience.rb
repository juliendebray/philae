class AddCategoryToExperience < ActiveRecord::Migration
  def change
    add_reference :experiences, :category, index: true
  end
end
