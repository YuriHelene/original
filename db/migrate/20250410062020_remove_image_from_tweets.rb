class RemoveImageFromTweets < ActiveRecord::Migration[7.1]
  def change
    remove_column :tweets, :image, :string
  end
end
