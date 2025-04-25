class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 教材7-2
    # @tweets = Tweet.all
    # search = params[:search]
    # @tweets = @tweets.joins(:user).where("body LIKE ?", "%#{search}%") if search.present?
    if params[:search].present?
      @tweets = Tweet.where("body LIKE ?", "%" + params[:search] + "%")
    else
      @tweets = Tweet.all
    end

    @tweets = Tweet.includes(:user).order(created_at: :desc)
    # 4/11追加
    @tweets = @tweets.page(params[:page]).per(4)
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
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :image, tag_ids: [])
  end

end
