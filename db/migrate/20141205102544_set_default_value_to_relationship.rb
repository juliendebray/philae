class SetDefaultValueToRelationship < ActiveRecord::Migration
  def change
    change_column_default(:relationships, :status, 'pending')
  end
end
