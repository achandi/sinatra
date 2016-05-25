class Addcolumntompvoting < ActiveRecord::Migration
  def change
    change_table :voting_mp_records do |t|
      t.string :mp_party
    end
  end
end
