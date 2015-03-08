module Pagination
  extend ActiveSupport::Concern

  included do
    class << self
      attr_accessor :pagination
    end

    def self.paginate(options = {})
      page = options[:page].to_i || 0
      per_page = options[:per_page].to_i || 10
      self.pagination = {
        current_page: page,
        per_page: per_page,
        total_records: self.count,
        total_pages: (self.count.to_f / per_page).ceil
      }
      self.limit(per_page).offset(page * per_page)
    end
  end
end
