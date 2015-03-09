class Correspondence < ActiveRecord::Base

  belongs_to :creator, :class_name => "User"
  belongs_to :participant, :class_name => "User"

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

end
