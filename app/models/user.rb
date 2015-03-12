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
  has_many :favorites, dependent: :destroy

  has_many :my_followers, foreign_key: :following_id, dependent: :destroy, class_name: "Relationship"
  has_many :followers, through: :my_followers

  has_many :my_followings, foreign_key: :follower_id, dependent: :destroy, class_name: "Relationship"
  has_many :followings, through: :my_followings


  def in_correspondence?(correspondence)
    self == correspondence.creator || self == correspondence.participant
  end

  def all_correspondences
    self.created_correspondences + self.participated_correspondences
  end

  def favorited(correspondence)
    favorites.where(correspondence_id: correspondence.id).first
  end

  def is_following(user)
    Relationship.where("follower_id = ? AND following_id = ?", self.id, user.id).first
  end

end
