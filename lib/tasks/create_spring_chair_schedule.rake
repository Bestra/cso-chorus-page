require 'csv'
require 'date'
namespace :chairs do

  def assign_simple_chairs(start_date, end_date, members_per_week)
    Member.where(no_chairs: nil).update_all(no_chairs: false)
    active_members = Member.active.where(no_chairs: false, scheduled_chair_date: nil)
    start_week = Date.parse start_date
    end_week = Date.parse end_date
    member_groups = active_members.shuffle.in_groups_of(5)
    member_groups.each_with_index.each do |week_list, week_index|
      current_week = start_week + week_index.weeks
      if current_week <= end_week
        puts "Scheduling for #{current_week}"
        week_list.compact.each do |member|
          member.update_attribute('scheduled_chair_date', current_week)
        end
      end
    end
  end

  desc "make chairs without a buddy list"
  task :assign, [:start_date, :end_date] => :environment do |t, args|
    assign_simple_chairs(args[:start_date], args[:end_date], 5)
  end

  desc "clear any chair assignments"
  task clear: :environment do
    Member.update_all(scheduled_chair_date: nil)
  end

  desc "output chair csv file"
  task :chair_csv, [:num_weeks] => :environment do |t, args|
    max_date = Date.today + args[:num_weeks].to_i.weeks
    puts max_date
    CSV.open("/users/Chris/Downloads/spring_chair_schedule1.csv", "wb") do |csv|
      schedule_members = Member.where('scheduled_chair_date IS NOT NULL').includes(:voice_part)
      .where('scheduled_chair_date < ?', max_date).order('voice_part_id ASC', 'last_name ASC')
      schedule_members.each do |m|
        csv << ["#{m.last_name}, #{m.first_name}", m.scheduled_chair_date, m.voice_part.description]
      end
    end
  end
end
