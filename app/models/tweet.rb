class Tweet < ActiveRecord::Base

  def self.score(mp)
    mps_tweets = Tweet.where(mp_id: mp)
    # binding.pry
    participation_count = 0
    mps_tweets.each do |tweet|
      if tweet.text[0] == '@' || tweet.text[0] == '.' && tweet.text[1] == '@'
        participation_count += 1
      elsif tweet.quoted_status != "N/A"
        participation_count += 1
      end
    end
    # TODO: make sure you're not dividing by zero!
    participation_count = (participation_count /  mps_tweets.length.to_f)
  end

end

