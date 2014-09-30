require 'csv'
require 'date'
namespace :chairs do

  def assign_simple_chairs(start_date, number_of_weeks, members_per_week)
    Member.where(no_chairs: nil).update_all(no_chairs: false, scheduled_chair_date: nil)
    active_members = Member.active.where(no_chairs: false, scheduled_chair_date: nil)
    week0 = Date.parse start_date
    member_groups = active_members.shuffle.in_groups_of(5)
    member_groups.each_with_index.map do |week_list, week_index|
      week_list.compact.each do |member|
        member.scheduled_chair_date = (week0 + week_index.weeks)
        member.save
      end
    end
  end

  desc "make chairs without a buddy list"
  task simple_chair_schedule: :environment do
    assign_simple_chairs('2014-10-07', 12, 5)
  end

  desc "output chair csv file"
  task :chair_csv, [:num_weeks] => :environment do |t, args|
    max_date = Date.today + args[:num_weeks].to_i.weeks
    puts max_date
    CSV.open("/users/Chris/Downloads/spring_chair_schedule1.csv", "wb") do |csv|
      schedule_members = Member.where('scheduled_chair_date IS NOT NULL')
      .where('scheduled_chair_date < ?', max_date).order('voice_part_id ASC', 'last_name ASC')
      schedule_members.each do |m|
        csv << ["#{m.last_name}, #{m.first_name}", m.scheduled_chair_date]
      end
    end
  end
end
