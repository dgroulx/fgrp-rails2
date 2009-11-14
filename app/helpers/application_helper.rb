# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_messages
    returning "" do |str|
      %w(notice failure success).each do |key|
        str << content_tag(:p, flash[key], :class => key) if flash[key]
      end
    end
  end
  
  
  def section(klasses)
    content_for(:section, klasses)
  end
end
