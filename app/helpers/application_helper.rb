module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Catequesis"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def flash_class(messageType = "default")
    "alert alert-#{messageType}"
  end

  def flash_icon(iconType = "default")
    case iconType
    when "default", "primary" then "pficon pficon-help"
    when "info" then "pficon pficon-info"
    when "success" then "pficon pficon-ok"
    when "warning" then "pficon pficon-warning-triangle-o"
    when "danger" then "pficon pficon-error-circle-o"
    end
  end

  def week_day_convert(day)
    week = {1 => 'Lunes', 2 => 'Martes', 3 => 'Miércoles', 4 => 'Jueves', 5 => 'Viernes', 6 => 'Sábado', 7 => 'Domingo'}
    week[day] || 'Ninguno'
  end
end
