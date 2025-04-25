class AddTitleToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :title, :string
  end
end
