class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :liked_users, through: :favorites, source: :user 
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search,word)
      if search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
      elsif search == "backword"
      @book == Book.where("title LIKE?","%#{word}")
      elsif search == "perfect_,match"
      @book = Book.where("#{word}")
      elsif search == "partial_match"
      @book = Book.where("%#{word}%")
      else
      @book = Book.all
      end
  end
  
end
