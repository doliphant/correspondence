class Comment < ActiveRecord::Base
  belongs_to :correspondence
  belongs_to :user
end
