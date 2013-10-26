class MoveChairScheduleIntoMember < ActiveRecord::Migration
  def up
    drop_table :chair_schedules
    add_column :members, :scheduled_chair_date, :datetime
  end

  def down
    create_table :chair_schedules do |t|
      t.integer :member_id
      t.datetime :schedule_date

      t.timestamps
    end

    remove_column :members, :scheduled_chair_date
  end
end
