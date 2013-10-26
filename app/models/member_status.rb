class MemberStatus < ActiveRecord::Base
  attr_accessible :description
  has_many :members

  def self.select_options
    MemberStatus.all.map do |s|
      [s.id, s.description]
    end
  end
end
