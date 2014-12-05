class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :user, index: true
      t.integer :friend_id
      t.integer :sender_id
      t.string :status

      t.timestamps
    end
  end
end
