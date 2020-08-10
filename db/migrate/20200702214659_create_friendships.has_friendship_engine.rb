# This migration comes from has_friendship_engine (originally 1)
class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.integer  :friend_id
      t.string   :status
      t.references :user, foreign_key: true
      t.datetime :accepted_at
      t.timestamps
    end
  end
end
