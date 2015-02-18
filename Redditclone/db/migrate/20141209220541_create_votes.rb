class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.string :votable_type
      t.integer :votable_id
      t.integer :voter_id

      t.timestamps
    end
    add_index :votes, [:voter_id, :votable_type, :votable_id], unique: true

  end
end
