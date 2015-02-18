class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :tag
      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :tag_index
      t.integer :url_index
      t.timestamps
    end
  end
end
