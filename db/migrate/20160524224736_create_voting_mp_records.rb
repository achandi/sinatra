class CreateVotingMpRecords < ActiveRecord::Migration
  def change
  create_table :voting_mp_records do |t|
      t.string :mp_id
      t.string :mp_name
      t.string :vote
      t.string :bill_vote
    end
  end
end
