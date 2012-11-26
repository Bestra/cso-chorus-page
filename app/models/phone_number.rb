class PhoneNumber < ActiveRecord::Base
  attr_accessible :member_id, :number, :phone_type_id, :publish
  belongs_to :member
  belongs_to :phone_type
  accepts_nested_attributes_for :phone_type
  validates :member_id, :number, :phone_type_id, presence: true 
end
