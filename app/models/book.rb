class Book < ApplicationRecord

	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def self.search(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE ?", "#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE ?", "%#{word}%")
    elsif search == "forward_match"
      @book = Book.where("title LIKE ?", "#{word}_")
    elsif search == "backward_match"
      @book = Book.where("title LIKE ?", "_#{word}")
    else
      @book = Book.all
    end
	end
end
