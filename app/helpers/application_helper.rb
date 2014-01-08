module ApplicationHelper

  def sort_column(default="id")
    Member.column_names.include?(params[:sort]) ? params[:sort] : default
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def update_filter(max)
    unless (0..max).include?(params[:filter].to_i)
      params[:filter] = 0
    end
  end

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

  def member_status_options
    @status_options ||= MemberStatus.all.map do |s|
      [s.id, s.description]
    end
  end

  def sortable(column_name, column_title=nil)
    column_title ||= column_name.titleize
    direction = column_name == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_title = column_name ==sort_column ? column_title + direction_arrow() : column_title

    link_to raw("#{link_title}"), {sort: column_name, direction: direction, filter: params[:filter]}, class: "btn"
  end
end
