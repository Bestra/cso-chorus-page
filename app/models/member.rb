class Member < ActiveRecord::Base
  has_many :phone_numbers, :dependent => :destroy
  has_one :folder, :dependent => :destroy
  belongs_to :voice_part
  has_many :email_addresses, :dependent => :destroy
  belongs_to :member_status, foreign_key: :status_id

  scope :active, -> { where(status_id: 1) }

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
    e.address if e
  end



  validates :first_name, :last_name, :status_id, :voice_part_id, :presence => true
  accepts_nested_attributes_for :phone_numbers, :reject_if => lambda { |a| a[:number].blank? }, allow_destroy: true
  accepts_nested_attributes_for :email_addresses, :reject_if => lambda { |a| a[:address].blank? }, allow_destroy: true

  #items for photo upload via paperclip, cropping via jcrop

  has_attached_file :photo, :styles => {:thumb => ["95x120#", :jpg], :large => ["500x500>", :jpg]},
    :processors => [:cropper],

    url: "Pics/:id_:style.:extension",
    default_url: "Pics/no_image_thumb.jpg",
    path: ":rails_root/app/assets/images/Pics/:id_:style.:extension"

  validates_attachment_size :photo, :less_than => 2.megabytes

  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h

  def reprocess_photo
    photo.reprocess!
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end


end
