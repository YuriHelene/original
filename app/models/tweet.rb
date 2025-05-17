class Tweet < ApplicationRecord
  attr_accessor :hashtag_name  # ← これを追加！

  belongs_to :user
  has_one_attached :image

  has_many :tag_maps, dependent: :destroy
  has_many :hashtags, through: :tag_maps

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :comments, dependent: :destroy

  #tweetsテーブルから中間テーブルに対する関連付け
  has_many :tweet_tag_relations, dependent: :destroy
  #tweetsテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :tweet_tag_relations, dependent: :destroy

  scope :latest, -> {order(created_at: :desc)}
  scope :oldest, -> {order(created_at: :asc)}
  scope :most_liked, -> {
    left_joins(:likes)
    .group(:id)
    .order('COUNT(likes.id) DESC')
  }

  def save_hashtag(sent_hashtags)
    current_hashtags = self.hashtags.pluck(:hashtag_name) unless self.hashtags.nil?
    old_hashtags = current_hashtags - sent_hashtags
    new_hashtags = sent_hashtags - current_hashtags

    old_hashtags.each do |old|
      self.hashtags.delete Hashag.find_by(hashtag_name: old)
    end

    new_hashtags.each do |new|
      new_tweet_hashtag = Hashag.find_or_create_by(hashtag_name: new)
      self.hashtags << new_tweet_hashtag
    end
  end

end
