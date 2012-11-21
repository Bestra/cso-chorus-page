module MembersHelper

  def picture_label(pic_exists)
    out = ""
    if pic_exists 
      out = content_tag( :span,"Yes", :class => "label label-success")
    else
      out = content_tag( :span, "No", :class => "label label-warning")
    end
  end

  def status_label(text)
    status_labels = {
      "Active"=> "success",
      "Inactive"=> "default",
      "Leave"=> "warning",
      "Special"=> "info"
    }

    if status_labels.include?(text)
      out = content_tag( :span,text, :class => "label label-#{status_labels[text]}")
    else
      out = content_tag( :span,text, :class => "label label-default")
    end
  end

end
