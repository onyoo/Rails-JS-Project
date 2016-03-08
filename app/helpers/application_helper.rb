# Helper method to dynamically set titles on pages
module ApplicationHelper

  def title(text)
    content_for :title, text
  end

end
