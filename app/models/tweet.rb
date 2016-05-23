class Tweet < ActiveRecord::Base
  def self.score(mp)
   mps_tweets = Tweet.where(mp_id: mp)
   # puts mp_tweets
   participation_count = 0 
   mps_tweets.each do |tweet|
    binding.pry
    if tweet['text'][0] == '@' || tweet['text'][0] == '.' && tweet['text'][1] == '@'
        participation_count += 1
      elsif not tweet['quoted_status'] == "N/A"
        participation_count += 1
    end
  end
  participation_count = (participation_count /  Tweet.count('mp_id', :conditions => "mp_id = mp"))
  return participation_count
end

end


# if tweet['text'][0] == '@' || tweet['text'][0] == '.' && tweet['text'][1] == '@'
#         participation_count += 1
#       elsif not tweet['quoted_status'] == "N/A"
#         participation_count += 1