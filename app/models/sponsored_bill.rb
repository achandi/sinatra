class SponsoredBill < ActiveRecord::Base

  def self.arr(mp)
    mps_sponsored_bill = SponsoredBill.where(mp_id: mp)
    spons_bill_array = []
    mps_sponsored_bill.each do |bill|
      # binding.pry
      hash = {}
      if bill.billInfo != "False"
       bill_hash = {"bill": bill.billNumber, "date_introducted": bill.dateIntroduced, "description": bill.descriptionEN}
       # binding.pry
        spons_bill_array.push(bill_hash)
      # binding.pry
     else 
      spons_bill_array.push(bill.billNumber)
      end
    # TODO: make sure you're not dividing by zero!
    end
   spons_bill_array

  end

  def self.bill_count(mp)
    mps_sponsored_bill = SponsoredBill.where(mp_id: mp)
    bill_count_array = []
    mps_sponsored_bill.each do |bill|
      # binding.pry
      bill_count_array.push(bill)
    end
  bill_count_array

  end

end



