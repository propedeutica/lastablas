module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Catequesis"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def flash_class(messageType = "primary")
    case messageType
    when "default", "primary", "alert" then "alert alert-info"
    when "notice", "success" then "alert alert-success"
    when "alert", "warning" then "alert alert-warning"
    else "alert alert-#{messageType}"
    end
  end

  def flash_icon(iconType = "primary")
    case iconType
    when "default", "primary", "alert" then "pficon pficon-help"
    when "info" then "pficon pficon-info"
    when "notice", "success" then "pficon pficon-ok"
    when "warning" then "pficon pficon-warning-triangle-o"
    when "alert", "danger" then "pficon pficon-error-circle-o"
    end
  end

  def week_day_convert(day)
    week = {1 => 'Lunes', 2 => 'Martes', 3 => 'Miércoles', 4 => 'Jueves', 5 => 'Viernes', 6 => 'Sábado', 7 => 'Domingo'}
    week[day] || 'Ninguno'
  end
end
