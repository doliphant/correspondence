class Discussion < ActiveRecord::Base
  has_many :posts, dependent: :destroy
    # when posts are built
    # dependent: :destroy
end
