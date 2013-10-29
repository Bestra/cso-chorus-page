class VoicePartSerializer < ActiveModel::Serializer
  attributes :id, :abbreviation, :description, :part, :section
end
