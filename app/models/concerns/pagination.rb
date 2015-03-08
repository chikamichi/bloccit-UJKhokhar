module Pagination
  extend ActiveSupport::Concern

  included do
    def self.paginate(options)
      page = options[:page] || 0
      per_page = options[:per_page] || 10
      self.limit(options[:per_page]).offset(page * per_page)
    end
  end
end
