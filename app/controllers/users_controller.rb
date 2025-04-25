class UsersController < ApplicationController

  def show
    @user = User.find(params[:id]) 
    # @tweets = @user.tweets
    @tweet = Tweet.find_by(user_id:params[:id])
  end

end
