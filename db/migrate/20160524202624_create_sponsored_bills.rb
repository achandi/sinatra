class CreateSponsoredBills < ActiveRecord::Migration
  def change
     create_table :sponsored_bills do |t|
      t.string :billInfo
      t.string :mpName
      t.string :mp_id
      t.string :billNumber
      t.string :descriptionEN
      t.string :descriptionFR
      t.string :dateIntroduced
      t.integer :legisinfoID
    end
  end
end
