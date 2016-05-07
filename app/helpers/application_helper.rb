module ApplicationHelper
  def full_title(page_title = '')
    base_title= "Catequesis"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def flash_class(level)
    case level
      when "notice" then 'alert alert-info'
      when "default" then 'alert alert-default'
      when "primary" then 'alert alert-primary'
      when "success" then 'alert alert-success'
      when "info" then 'alert alert-info'
      when "warning" then 'alert alert-warning'
      when "danger" then 'alert alert-danger'
      when "alert" then 'alert alert-warning'
      else 'alert alert-default'
    end
  end

  def flash_icon(level)

    case level
      when "notice" then "pficon pficon-info"
      when "default" then "pficon pficon-default"
      when "primary" then "pficon pficon-help"
      when "info" then "pficon pficon-info"
      when "success" then "pficon pficon-ok"
      when "warning" then "pficon pficon-warning-triangle-o"
      when "danger" then "pficon pficon-error-circle-o"
      when "alert" then "pficon pficon-warning-triangle-o"
      else "pficon pficon-info"
    end
  end

  def week_day_convert(day)
    case day
      when 1 then "Lunes"
      when 2 then "Martes"
      when 3 then "Miécoles"
      when 4 then "Jueves"
      when 5 then "Viernes"
      when 6 then "Sábado"
      when 7 then "Domingo"
      else "Ninguno"
    end
  end

end
