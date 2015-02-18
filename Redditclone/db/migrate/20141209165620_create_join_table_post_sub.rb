class CreateJoinTablePostSub < ActiveRecord::Migration
  def change
    create_join_table :posts, :subs do |t|
      t.index [:post_id, :sub_id]
      t.index [:sub_id, :post_id]
    end
  end
end
