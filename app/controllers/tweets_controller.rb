class TweetsController < ApplicationController
  # before_action :authenticate_user!
  # ログインしないと投稿を見れなくする仕組み

  def index
    @tweets = Tweet.includes(:user, :image_attachment, :image_blob, :likes).order(created_at: :desc)
    # @hashtag_list = Hashtag.all              #ビューでタグ一覧を表示するために全取得。
    @tweet_hashtags = Hashtag.includes(:tweets).all
    @hashtag_list = Hashtag.joins(:tweets).group('hashtags.id').having('COUNT(tweets.id) > 0')    # 教材7-2
    # @tweets = Tweet.all
    # search = params[:search]
    # @tweets = @tweets.joins(:user).where("body LIKE ?", "%#{search}%") if search.present?
    if params[:search].present?
      @tweets = Tweet.where("body LIKE ?", "%" + params[:search] + "%")
    else
      @tweets = Tweet.all

    @tweets = case params[:sort]
              when 'old'
                Tweet.oldest
              when 'likes'
                Tweet.most_liked
              else
                Tweet.latest
              end
    end

    # 4/11追加
    @tweets = @tweets.page(params[:page]).per(24)
    # ページネーション
  end

  def new
    @tweet = Tweet.new
    # @tweet = current_user.tweet.new # ビューのform_withのmodelに使う。
  end

  # def create
  #   tweet = Tweet.new(tweet_params)
  #   tweet.user_id = current_user.id 
  #   if tweet.save
  #     redirect_to :action => "index"
  #   else
  #     redirect_to :action => "new"
  #   end
  # end

  def create
    @tweet = current_user.tweets.new(tweet_params)           
    hashtag_list = params[:tweet][:hashtag_name].split(nil)  
    if @tweet.save
        @tweet.save_hashtag(hashtag_list)
        redirect_to :action => "index"
    else
        redirect_to :action => "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_hashtags = @tweet.hashtags #そのクリックした投稿に紐付けられているタグの取得。

    @comments = @tweet.comments
    @comment = Comment.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def hashtag
    @hashtag = Hashtag.find(params[:id])
    @tweets = @hashtag.tweets.includes(:user, :image_attachment, :image_blob, :likes).order(created_at: :desc).page(params[:page]).per(24)
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      hashtags = params[:tweet][:hashtag_name].split(" ")
      tweet.save_hashtag(hashtags) 
      redirect_to :action => "show", :id => tweet.id, notice: "投稿を更新しました"
    else
      redirect_to :action => "edit"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :body, :image, :hashtag_name) #tag_ids: []
  end

end
