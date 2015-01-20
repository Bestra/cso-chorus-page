require 'csv'
class ChairScheduleController < MembersOnlyController
  # GET /chair_schedules
  # GET /chair_schedules.json
  include ApplicationHelper
  def index
    end_date = Date.today + scheduled_weeks.weeks
    @members = Member.where('scheduled_chair_date IS NOT NULL')
      .includes(:voice_part, :email_addresses)
      .where('scheduled_chair_date > ?', start_date)
      .where('scheduled_chair_date < ?', end_date).order('last_name ASC')

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
  def start_date
    Date.parse (params[:start_date] || "2015-1-1")
  end

  def scheduled_weeks
    if params[:weeks]
      params[:weeks].to_i
    else
      13
    end
  end

  def member_csv_array(members)
    CSV.generate do |csv|
      members.each do |m|
        csv << ["#{m.last_name}, #{m.first_name}", m.scheduled_chair_date, m.voice_part.description]
      end
    end
  end
end
