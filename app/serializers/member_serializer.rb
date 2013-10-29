class MemberSerializer < ActiveModel::Serializer
  self.root false
  attributes :id, :first_name, :last_name
  has_one :voice_part, embed: :ids, include: true
  has_one :member_status, embed: :ids, include: true
end
