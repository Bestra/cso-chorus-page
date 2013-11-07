class MemberStatus < ActiveRecord::Base
  attr_accessible :description
  has_many :members
end
