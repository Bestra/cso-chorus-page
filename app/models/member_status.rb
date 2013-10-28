class MemberStatus < ActiveRecord::Base
  attr_accessible :description
  has_many :members

  def self.select_options
    MemberStatus.all.map do |s|
      [s.id, s.description]
    end
  end

  alias_method :old_as_json, :as_json
  def as_json(*args)
    old_as_json(root: true, only: [:id, :description])
  end
end
