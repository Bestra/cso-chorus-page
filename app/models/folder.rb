class Folder < ActiveRecord::Base
  attr_accessible :member_id
  belongs_to :member
end
