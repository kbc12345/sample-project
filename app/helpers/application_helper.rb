module ApplicationHelper

  def is_active action
    params[:action] == action ? 'active' : ''
  end

  def format_date(date)
    date.blank? ? "" : date.strftime("%B %d %Y")
  end

end
