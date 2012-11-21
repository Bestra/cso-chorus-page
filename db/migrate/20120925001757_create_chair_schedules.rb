class CreateChairSchedules < ActiveRecord::Migration
  def change
    create_table :chair_schedules do |t|
      t.integer :member_id
      t.datetime :schedule_date

      t.timestamps
    end
  end
end
