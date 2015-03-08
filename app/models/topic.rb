class Topic < ActiveRecord::Base
  extend Paginate

  has_many :posts, dependent: :destroy
end
