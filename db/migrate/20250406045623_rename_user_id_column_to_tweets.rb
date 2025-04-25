class RenameUserIdColumnToTweets < ActiveRecord::Migration[7.1]
  def change
    rename_column :tweets, :userId, :user_id
  end
end
