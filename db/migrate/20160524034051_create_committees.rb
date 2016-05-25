class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.string :mp_id
      t.string :committee_title
    end
  end
end

