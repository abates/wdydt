module ApplicationHelper
  def active_class url
    current_page?(url) ? "active" : ""
  end

  def link_to(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    html_options["href"] ||= url

    html_options["class"] ||= ""
    html_options["class"] += " " + active_class(html_options["href"])
    content_tag(:a, name || url, html_options, &block)
  end

  def flash_tag flash
    type = flash[0]
    message = flash[1]

    specific_class = case type
                     when "notice"
                       "alert-success"
                     when "alert"
                       "alert-danger"
                     when "flash"
                       "alert-info"
                     end

    content_tag(:div, class: "alert #{specific_class}", role: "alert") do
      message
    end
  end
end
