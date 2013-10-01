class AddNoChairsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :no_chairs, :boolean
  end
end
