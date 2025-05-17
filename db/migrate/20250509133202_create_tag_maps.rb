class CreateTagMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :tag_maps do |t|
      t.references :tweet, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
