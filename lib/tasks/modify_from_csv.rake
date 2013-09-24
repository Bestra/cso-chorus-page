require 'csv'
require 'set'
namespace :db do

  def csv_modify(file_path)
    new_active_ids = []
    CSV.foreach("#{file_path}", headers: true) do |row|
      new_active_ids << row[5].to_i
    end
    old_active_ids = Member.where(status_id: 1).select('id').map { |m| m.id }
    puts old_active_ids.inspect
    puts new_active_ids.inspect
    inactive_people = old_active_ids - new_active_ids
    inactive_people.each do |p|
      m =  Member.find(p)
      puts m.name
      m.status_id = 4
      m.save
    end
  end

  desc "Read the members  .tsv file in /app/assets/"
  task update_member_status: :environment do
    csv_modify('/users/Chris/Downloads/cso_active_members.csv')
  end
end

