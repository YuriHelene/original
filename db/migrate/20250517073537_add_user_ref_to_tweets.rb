class AddUserRefToTweets < ActiveRecord::Migration[7.1]
  def change
    add_reference :tweets, :user, null: true, foreign_key: true, index: true
  end
end
