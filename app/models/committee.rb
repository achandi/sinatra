class Committee < ActiveRecord::Base

  def self.arr(mp)
    mps_committee = Committee.where(mp_id: mp)
    comm_array = []
    mps_committee.each do |commit|
      comm_array.push(commit.committee_title)
    end
    # TODO: make sure you're not dividing by zero!
    comm_array
  end

end