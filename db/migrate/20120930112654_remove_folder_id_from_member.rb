class RemoveFolderIdFromMember < ActiveRecord::Migration
  def up
    remove_column :members, :folder_id
      end

  def down
    add_column :members, :folder_id, :integer
  end
end
