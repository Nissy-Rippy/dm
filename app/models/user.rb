class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  def follow(user_id)
      relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
      relationships.find_by(followed_id: user_id).destroy
  end

  def followings?(user)
      followings.include?(user)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_rooms,dependent: :destroy
  has_many :chats,dependent: :destroy

  has_many :reverse_of_relationships,class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  has_many :followers,through: :reverse_of_relationships,source: :follower
  has_many :relationships,class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  has_many :followings,through: :relationships,source: :followed
  
  has_many :books
  
  has_many :group_users
  has_many :groups, through: :group_users
  
  
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end
