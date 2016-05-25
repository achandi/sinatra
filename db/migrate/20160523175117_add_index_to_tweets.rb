class AddIndexToTweets < ActiveRecord::Migration
  def change
  add_index :tweets, :mp_id
  end
end
