module AttachedPhoto
  #items for photo upload via paperclip, cropping via jcrop
 def AttachedPhoto.included(klass)
   klass.class_eval do
    has_attached_file :photo, :styles => {:thumb => ["95x120#", :jpg], :large => ["500x500>", :jpg]},
      :processors => [:cropper],

      url: "Pics/:id_:style.:extension",
      default_url: "Pics/no_image_thumb.jpg",
      path: ":rails_root/app/assets/images/Pics/:id_:style.:extension"

    validates_attachment_size :photo, :less_than => 2.megabytes
    #need attr_accessors because these fields aren't persisted to the database.
    crop_attrs = %i(crop_x crop_y crop_w crop_h)
    attr_accessor *crop_attrs
    attr_accessible *crop_attrs
   end
 end

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