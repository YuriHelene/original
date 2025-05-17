class Hashtag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy, foreign_key: 'hashtag_id'
  has_many :tweets, through: :tag_maps
end
