class CreateHashtags < ActiveRecord::Migration[7.1]
  def change
    create_table :hashtags do |t|
      t.string :hashtag_name

      t.timestamps
    end
  end
end
