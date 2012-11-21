class ChairSchedule < ActiveRecord::Base
  attr_accessible :member_id, :schedule_date
  belongs_to :member
end
