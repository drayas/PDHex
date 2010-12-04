# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def show_flash
    if flash[:error]
      return '<div class="error">' + flash[:error] + '</div>' 
    end
    return ""
  end
end
