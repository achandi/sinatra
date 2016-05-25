class VotingMpRecord < ActiveRecord::Base
    
  def self.missed_votes(mp)
    votes_cast = VotingMpRecord.where(mp_id: mp)
    missed_vote_count = 0
    votes_cast.each do |vote|
      if vote["vote"]== "N/A"
         missed_vote_count += 1
      end
    end
    missed_vote_count
  end

end


class VotingMpRecord < ActiveRecord::Base
    
  def self.vote_by_party(bill_vote)
    votes_cast = VotingMpRecord.where(bill_vote: bill_vote)
      ndp = 0
      cons = 0 
      lib = 0 
      green = 0 
      bloc = 0

    array = [] 
    votes_cast.each do |vote|
      case vote["mp_party"]
        when "NDP"
          vote["vote"] == "Yes" ? ndp += 1 : ndp -= 1
        when "Bloc Québécois"
          vote["vote"] == "Yes" ? bloc += 1 : bloc -= 1
        when "Liberal"
          vote["vote"] == "Yes" ? lib += 1 : lib -= 1
        when "Green Party"
          vote["vote"] == "Yes" ? green += 1 : green -= 1
        when "Conservative"
          vote["vote"] == "Yes" ? cons += 1 : cons -= 1
      end
    end
    binding.pry
  end
end



# class VotingMpRecord < ActiveRecord::Base
    
#   def self.vote_by_party(mp)
#     votes_cast = VotingMpRecord.where(mp_id: mp)
#     # ndp = "NDP"
#     ndp = 0
#     # bloc = "Bloc Québécois"
#     bloc = 0
#     # liberal = "Liberal"
#     liberal = 0
#     # green = "Green Party"
#     green = 0
#     # conservative = "Conservative"
#     conservative = 0
#     # binding.pry
#     votes_cast.each do |vote|

#       vote_for = vote["bill_vote"]
#       # if vote["vote"]== "N/A"
#       #    missed_vote_count += 1
#       # end
#     end
#     missed_vote_count
#   end

# end





