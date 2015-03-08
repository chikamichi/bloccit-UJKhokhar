module Paginate
  def paginate(options)
    page = options[:page] || 0
    per_page = options[:per_page] || 10
    self.limit(options[:per_page]).offset(page * per_page)
  end
end
