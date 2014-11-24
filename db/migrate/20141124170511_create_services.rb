class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :experience, index: true
      t.references :provider, index: true

      t.timestamps
    end
  end
end
