class VoicePart < ActiveRecord::Base
  attr_accessible :id, :abbreviation, :description, :part, :section
  has_many :members
end
