class RemoveSubidColumnFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :sub_id

  end
  def down
    add_column :posts, :sub_id
    add_index :posts, :sub_id
  end

end
