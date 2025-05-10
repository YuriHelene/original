class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  has_many :tweets, dependent: :destroy #ユーザーが削除されたら、ツイートも削除されるようになる
  validates :name, presence: true 
  validates :profile, length: { maximum: 200 }

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  # has_many :tweets
  has_one_attached :icon  # "icon" はアイコン画像の名前（任意）

  def already_liked?(tweet)  #すでにいいねをしているのか
    self.likes.exists?(tweet_id: tweet.id)
  end

  def acceptable_icon
    return unless icon.attached?
  
    # unless avatar.blob.byte_size <= 1.megabyte
    #   errors.add(:avatar, "は1MB以下のファイルにしてください")
    # end
  
    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(icon.content_type)
      errors.add(:icon, "はJPEGまたはPNG形式のみ許可されています")
    end
  end
  
end
