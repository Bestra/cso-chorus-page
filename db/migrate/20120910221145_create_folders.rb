class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.integer :member_id

      t.timestamps
    end
  end
end
