class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.text :address
      t.string :name
      t.text :description
      t.string :category
      t.boolean :published
      t.references :user, index: true
      t.boolean :private
      t.timestamp :published_at

      t.timestamps
    end
  end
end
