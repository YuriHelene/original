class TweetsController < ApplicationController
  # before_action :authenticate_user!
  # ログインしないと投稿を見れなくする仕組み

  def index
    @tweets = Tweet.includes(:user, :image_attachment, :image_blob, :likes).order(created_at: :desc)

    # 教材7-2
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
    @tweets = @tweets.page(params[:page]).per(20)
    # ページネーション
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id 
    if tweet.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])

    @comments = @tweet.comments
    @comment = Comment.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
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
    params.require(:tweet).permit(:title, :body, :image, tag_ids: [])
  end

end
