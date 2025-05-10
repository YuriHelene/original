class Post < ApplicationRecord
  belongs_to :user

  has_many :tag_maps, dependent: :destroy
  has_many :hashtags, through: :tag_maps
# throughオプションを使う場合、先にその中間テーブルとの関連付けを行う必要がある。
# 中間テーブルにdependent: :destroyオプションを付けることで、Postが削除されると同時にPostとTagの関係が削除される。
end
