class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.text :body

      t.timestamps
    end
    add_column :tweets, :image, :string
  end
end
