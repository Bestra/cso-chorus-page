require 'csv'
class ChairScheduleController < MembersOnlyController
  # GET /chair_schedules
  # GET /chair_schedules.json
  include ApplicationHelper
  def index
    @members = Member.active.where('scheduled_chair_date >= ?', Date.parse('2014-01-01'))
    .includes(:email_addresses)
    .order(sort_column("scheduled_chair_date") + " " + sort_direction)

    @date_emails = @members.group_by(&:scheduled_chair_date).reduce({}) do |accum, (date, members)|
      accum[date.to_s] = members.map(&:email).join(',')
      accum
    end
    respond_to do |format|
      format.html # index.html.erb
      format.csv { render text: member_csv_array(@members) }
    end
  end

  private
  def member_csv_array(members)
    member_attrs = members.map do |m|
      [m.name, m.email, m.scheduled_chair_date]
    end
    CSV.generate do |csv|
      csv << ["Name", "Email", "Scheduled Date"]
      member_attrs.each do |m|
        csv << m
      end
    end
  end
end
