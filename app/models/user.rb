class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy #ユーザーが削除されたら、ツイートも削除されるようになる
  validates :name, presence: true 
  validates :profile, length: { maximum: 200 }

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  # has_many :tweets

  def already_liked?(tweet)  #すでにいいねをしているのか
    self.likes.exists?(tweet_id: tweet.id)
  end

end
