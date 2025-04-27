class UsersController < ApplicationController

  def show
    @user = User.find(params[:id]) 
    # @tweets = @user.tweets
    # @tweet = Tweet.find_by(user_id:params[:id])
    # @likes = Like.where(user_id: @user.id)
    # @liked_tweets = @user.liked_tweets
    @tweets = @user.tweets.page(params[:page]).per(4)
    @liked_tweets = @user.liked_tweets.page(params[:liked_page]).per(4)
  end

end
