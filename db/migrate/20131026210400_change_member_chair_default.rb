class ChangeMemberChairDefault < ActiveRecord::Migration
  def up
    change_column_default :members, :no_chairs, false
  end

  def down
    change_column_default :members, :no_chairs, nil
  end
end
