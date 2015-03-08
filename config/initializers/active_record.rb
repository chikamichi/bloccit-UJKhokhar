ActiveRecord::Base.send :include, Pagination
ActiveRecord::Associations::CollectionProxy.send :include, Pagination
