class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :name
      t.references :experience, index: true

      t.timestamps
    end
  end
end
