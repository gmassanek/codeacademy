module LinkHelper

  def link_li(link)
    content_tag :li, abbreviated_link_link(link) unless link.url.blank?
  end

  def abbreviated_link_link(link)
    link_to link_text(link), link.url, :target => "_blank"
  end
    
  def link_text(link)
    return link.description unless link.description.blank?
    show_width = 40
    if link.url.length > show_width
      link.url[0, show_width] + "..."
    else
      link.url
    end
  end

end
