class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower #自分がフォローしている人

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed #自分をフォローしている人

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true, presence: true
  validates :introduction, length: {maximum: 50}

    # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
  
  #検索機能
  def self.search(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE ?", "#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE ?", "%#{word}%")
    elsif search == "forward_match"
      @user = User.where("name LIKE ?", "#{word}_")
    elsif search == "backward_match"
      @user = User.where("name LIKE ?", "_#{word}")
    else
      @user = User.all
    end
  end
end
