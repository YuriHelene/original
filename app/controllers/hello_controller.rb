class HelloController < ApplicationController
  def top
    # 新規作成順に並び替えて、1件のモデルを取得
    @new_tweets = Tweet.order(created_at: :desc).limit(6)
  end
  
end
