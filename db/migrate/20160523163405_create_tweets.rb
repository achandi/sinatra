class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
    t.integer :mp_id
    t.string :text
    t.string :quoted_status 
  end
  end
end
