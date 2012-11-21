class EmailAddress < ActiveRecord::Base
  attr_accessible  :address, :member_id, :publish
  belongs_to :member
  validates  :address, :member_id, :publish, presence: true
end
