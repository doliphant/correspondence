class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        #  :confirmable - later

  has_many :created_correspondences, :foreign_key => "creator_id", :class_name => "Correspondence"
  has_many :participated_correspondences, :foreign_key => "participant_id", :class_name => "Correspondence"

  has_many :posts
  has_many :comments

  def in_correspondence?(correspondence)
    self == correspondence.creator || self == correspondence.participant
  end


end
