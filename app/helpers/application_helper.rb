module ApplicationHelper

  def bool_icon(value)
    if value
      content_tag(:i,"", class: "icon-ok")
    else
      content_tag(:i,"", class: "icon-remove")
    end
  end

  def direction_arrow()
    if sort_direction=="asc"
      content_tag(:i,"", class: "icon-arrow-up")
    else
      content_tag(:i,"", class: "icon-arrow-down")
    end
  end

  def sortable(column_name, column_title=nil)
    column_title ||= column_name.titleize
    direction = column_name == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_title = column_name ==sort_column ? column_title + direction_arrow() : column_title

    link_to raw("#{link_title}"), sort: column_name, direction: direction, filter: params[:filter]
  end
end
