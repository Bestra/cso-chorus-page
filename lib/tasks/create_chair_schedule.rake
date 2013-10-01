require 'csv'
require 'date'
namespace :chairs do

  MEMBERS_PER_WEEK = 5
  def create_chairs(file_path, number_of_weeks, members_per_week)
    active_ids = []
    chair_buddies = []
    CSV.foreach("#{file_path}", headers: true) do |row|
      unless row[7] #can't do chairs
        id = row[5].to_i
        active_ids << id
        if row[8]
          chair_buddies << [id, row[8].to_i]
        end
      end
    end

    schedule = schedule_members active_ids, chair_buddies, [], 1, number_of_weeks
    week0 = Date.parse "October 1"
    assignments = schedule.each_with_index.map do |week_list, week_index|
      week_members = Member.find week_list
      week_members.map { |m| [m.id, m.last_name, m.name, m.email, week_index + 1, week0 + week_index.weeks] }
    end

    csv_out = CSV.open("/users/Chris/Downloads/chair_schedule.csv", "wb") do |csv|
      assignments.flatten(1).each do |a|
        csv << a
      end
    end
  end

  def has_space?(schedule_array, members)
    member_group = Array(members)
    new_sched = schedule_array | member_group
    new_sched.count < MEMBERS_PER_WEEK + 1
  end

  def add_if_room(schedule_array, members)
    if has_space?(schedule_array, members)
      schedule_array | Array(members)
    else
      schedule_array
    end
  end

  def schedule_members(id_pool, buddies, overall_schedule, week, total_weeks)
    sample_size = id_pool.count < MEMBERS_PER_WEEK ? id_pool.count : MEMBERS_PER_WEEK
    initially_scheduled = id_pool.sample(sample_size)
    buddy_schedule = []
    initially_scheduled.each do |member|
      buddies.each do |buddy_group|
        if buddy_group.index(member)
          buddy_schedule = add_if_room(buddy_schedule, buddy_group)
        end
      end
    end
    initially_scheduled.each { |m| buddy_schedule = add_if_room(buddy_schedule, m) }
    new_schedule = overall_schedule << buddy_schedule
    if week == total_weeks
      new_schedule
    else
      schedule_members(id_pool - buddy_schedule, buddies, new_schedule, week + 1, total_weeks)
    end
  end

  desc "create a schedule for chairs"
  task make_chair_schedule: :environment do
    create_chairs('/users/Chris/Downloads/cso_active_members.csv', 10, 5)
  end
end

