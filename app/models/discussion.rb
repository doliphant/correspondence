class Discussion < ActiveRecord::Base

  belongs_to :creator, :class_name => "User"
  belongs_to :participant, :class_name => "User"

  has_many :posts, dependent: :destroy

end
