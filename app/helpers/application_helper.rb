# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def section(klasses)
    content_for(:section, klasses)
  end
end
