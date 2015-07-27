module ApplicationHelper

  def is_active action
    params[:controller].split("/")[1] == action ? 'active' : ''
  end

  def format_date(date)
    date.blank? ? "" : date.strftime("%B %d %Y")
  end

end
