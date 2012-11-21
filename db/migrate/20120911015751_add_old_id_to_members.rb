class AddOldIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :old_id, :integer
  end
end
