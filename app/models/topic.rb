class Topic < ActiveRecord::Base
  include Paginate

  has_many :posts, dependent: :destroy
end
