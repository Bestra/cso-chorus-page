class Member < ActiveRecord::Base
  include AttachedPhoto
  has_many :phone_numbers, :dependent => :destroy
  has_one :folder, :dependent => :destroy
  belongs_to :voice_part
  has_many :email_addresses, :dependent => :destroy
  belongs_to :member_status, foreign_key: :status_id

  scope :active, -> { where(status_id: 1) }
  scope :voice_part, ->(id) { id == 0 ? where(false) : where(voice_part_id: id) }

  scope :directory_details, -> { includes(:voice_part, :email_addresses, :phone_numbers => [:phone_type]) }
  scope :with_details, -> { includes(:member_status, :voice_part, :email_addresses, :phone_numbers => [:phone_type]) }

  attrs = %i(address city state zip date_joined
             first_name last_name program_name
             height photo_path photo publish_data
             status_id voice_part_id email_addresses_attributes
             phone_numbers_attributes no_chairs scheduled_chair_date)

  attr_accessible *attrs

  def check_program_name
    if program_name.present?
      program_name
    else
      [first_name, last_name].join ' '
    end
  end

  def no_chairs
    @no_chairs || false
  end

  def print_city_info
    if (self.city && self.state && self.zip)
      "#{self.city}, #{self.state} #{self.zip}"
    else
      ""
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def email
    e = self.email_addresses.try(:first)
    e ? e.address : "None"
  end

  def phone
    e = self.phone_numbers.try(:first)
    e ? e.number : "None"
  end



  validates :first_name, :last_name, :status_id, :voice_part_id, :presence => true
  accepts_nested_attributes_for :phone_numbers, :reject_if => lambda { |a| a[:number].blank? }, allow_destroy: true
  accepts_nested_attributes_for :email_addresses, :reject_if => lambda { |a| a[:address].blank? }, allow_destroy: true

end
