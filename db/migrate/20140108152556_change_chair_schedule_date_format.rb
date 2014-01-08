class ChangeChairScheduleDateFormat < ActiveRecord::Migration
  def up
    change_column :members, :scheduled_chair_date, :date
  end

  def down
    change_column :members, :scheduled_chair_date, :datetime
  end
end
