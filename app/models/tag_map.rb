class TagMap < ApplicationRecord
  belongs_to :tweet
  belongs_to :hashtag
  # 複数のPost、複数のTagに所有されるのでbelongs_toで関連付け

  validates :tweet_id, presence: true
  validates :hashtag_id, presence: true
end
