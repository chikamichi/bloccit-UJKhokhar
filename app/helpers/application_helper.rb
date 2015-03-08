module ApplicationHelper
  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

  # Paginate a collection of records: create a navigation bar with links to
  # previous/next pages.
  #
  # Same API than official will_paginate: https://github.com/mislav/will_paginate/blob/master/lib/will_paginate/view_helpers/action_view.rb#L26
  # but with less features (no inference, basic rendering…)
  #
  # @param collection [ActiveRecord::Relation] a collection of records
  def will_paginate(collection = nil, options = {})
    html = ""
    current_page = collection.pagination[:current_page]
    total_pages = collection.pagination[:total_pages]

    # Don't display pagination links if the collection is not paginated,
    # or there is only one page.
    return html if collection.nil?
    return html if total_pages == 1

    # If this is not the first page being displayed, add a link to the previous
    # page.
    if current_page > 0
      html << content_tag(:span, link_to("<- Previous", topics_path(page: current_page - 1)))
    end

    # Display a direct link for each page (but the current one).
    total_pages.times do |page|
      if page == current_page
        html << content_tag(:span, page, class: 'current')
      else
        html << content_tag(:span, link_to(page, topics_path(page: page)))
      end
    end

    # If this is not the last page being displayed, add a link to the next
    # page.
    if current_page < total_pages - 1
      html << content_tag(:span, link_to("Next ->", topics_path(page: current_page + 1)))
    end

    content_tag(:div, class: 'pagination') do
      html.html_safe
    end.html_safe
  end
end
