class PhoneNumber < ActiveRecord::Base
  attr_accessible :member_id, :number, :phone_type_id, :publish
  belongs_to :member
  belongs_to :phone_type
  accepts_nested_attributes_for :phone_type
  validates :member_id, :number, :phone_type_id, presence: true 

  def formatted_number
    if complete_number? && no_extension?
      b = bare_number
      [b[0..2],b[3..5],b[6..9]].join("-")
    else
      number
    end
  end

  private

  def complete_number?
    bare_number.length == 10
  end

  def no_extension?
    !number.include?("x")
  end

  def bare_number
    @bare_number ||= number.gsub(/\D/, '')
  end
end
