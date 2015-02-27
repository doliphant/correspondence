class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        #  :confirmable - later

  has_many :created_discussions, :foreign_key => "creator_id", :class_name => "Discussion"
  has_many :participated_discussions, :foreign_key => "participant_id", :class_name => "Discussion"

  has_many :posts, through: :discussions


end
