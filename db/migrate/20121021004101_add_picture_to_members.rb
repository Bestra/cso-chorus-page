class AddPictureToMembers < ActiveRecord::Migration
  def change
    add_column :members, :picture, :boolean
  end
end
