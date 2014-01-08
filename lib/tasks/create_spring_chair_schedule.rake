require 'csv'
require 'date'
namespace :chairs do

  MEMBERS_PER_WEEK = 5
  def create_chairs(start_date, number_of_weeks, members_per_week)
    Member.where(no_chairs: nil).each do |m|
      m.no_chairs = false
      m.save
    end
    active_ids = Member.active.where(no_chairs: false, scheduled_chair_date: nil).pluck(:id)
    chair_buddies = []

    schedule = schedule_members active_ids, chair_buddies, [], 1, number_of_weeks
    week0 = Date.parse start_date
    assignments = schedule.each_with_index.map do |week_list, week_index|
      week_members = Member.find week_list
      week_members.map { |m| [m.id, m.last_name, m.name, m.email, week_index + 1, week0 + week_index.weeks] }.flatten(1)
    end

    CSV.open("/users/Chris/Downloads/spring_chair_schedule.csv", "wb") do |csv|
      assignments.each do |a|
        csv << a
        Member.find(a[0]).scheduled_chair_date = a[5]
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

  desc "create a schedule for chairs using info already in the db."
  task make_spring_chair_schedule: :environment do
    create_chairs('2014-01-14', 17, 5)
  end
end

