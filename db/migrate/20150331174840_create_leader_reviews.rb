class CreateLeaderReviews < ActiveRecord::Migration
  def change
    create_table :leader_reviews do |t|
      t.references :experience, index: true
      t.string :source
      t.text :comment
      t.integer :rating

      t.timestamps
    end
  end
end
