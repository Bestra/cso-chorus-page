class VoicePart < ActiveRecord::Base
  attr_accessible :id, :abbreviation, :description, :part, :section
  has_many :members

  alias_method :old_as_json, :as_json
  def as_json(*args)
    old_as_json(root: true, except: [:created_at, :updated_at])
  end
end
