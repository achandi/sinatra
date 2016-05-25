require 'rake'
require 'json'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "store tweets in database"
task "db:extracttweets" do
  # for each file of tweets
  ["db/tweets1.json", "db/tweets2.json", "db/tweets3.json"].each do |file|
    # read the file
    json_file = File.read(file)
    # parse data into JSON
    json_data = JSON.parse(json_file)
    # for each tweet
    json_data.each do |tweet|
      Tweet.create({mp_id: tweet['mp_id'], text: tweet['text'], quoted_status: tweet['quoted_status']})
    end
  end
end

desc "calculate scores"
task "db:calculatescore" do
  distinct_mp_ids = Tweet.select(:mp_id).distinct.pluck(:mp_id)
  data = []
  distinct_mp_ids.each do |mp_id|
    score = Tweet.score(mp_id)
    puts score
    data.push({
      mp_id: mp_id,
      score: score
    })
  end
  File.open("score.json","w") do |f|
    f.write(data.to_json)
  end
end

desc "calculate sum"
task "db:calculate_sum" do 
  ["score.json"].each do |file|
   json_file = File.read(file)
    # parse data into JSON
    score_data = JSON.parse(json_file)
    # for each tweet
    # json_data.each do |score|
    # p score_data[0][:score
    # score_array = []
    score_array = score_data.map { |e| e["score"] }
    # binding.pry
    # # p score_array.first
    sum_value = score_array.inject(0){|accum, i| accum + i }
    # puts sum_value
    mean = (sum_value / score_array.length).to_f.round(2)
    puts mean
    delta_sum = score_array.inject(0){|accum, i| accum +((i-mean)**2) }
    puts delta_sum
    variance = (delta_sum/(score_array.length)).to_f.round(2)
    puts "variance + #{variance}"
    standard_deviation = (Math.sqrt(variance)).round(2)
    puts "#{standard_deviation} + standard_deviation"
    normalized_scores = []
    score_data.each do |score|
    mp_id = score['mp_id'] 
      # binding.pry
    new_score = ((((score['score']-mean)/standard_deviation)).abs * 10).round(1)
    # if new_score > 10
    #   new_score = 10
    # end
      # puts score
      normalized_scores.push({
      mp_id: mp_id,
      score: new_score
    })
    end
    File.open("new_score.json","w") do |f|
      f.write(normalized_scores.to_json)
    end
   end
 end


desc "store committees in database"
task "db:committee_seed" do
  # for each file of tweets
  ["db/committee_hash_members.json"].each do |file|
    # read the file
    json_file = File.read(file)
    # parse data into JSON
    json_data = JSON.parse(json_file)
    # for each tweet
    json_data.each do |item|
      Committee.create({mp_id: item['mp_id'], committee_title: item['committee_title']})
    end
  end
end


desc "committee array"
task "db:committee_array" do
  distinct_mp_ids = Committee.select(:mp_id).distinct.pluck(:mp_id)
  data = []
  distinct_mp_ids.each do |mp_id|
    list = Committee.arr(mp_id)
    tally = list.length
    data.push({
      mp_id: mp_id.to_i,
      committees: list,
      tally: tally.to_i
    })
  end
  File.open("committee.json","w") do |f|
    f.write(data.to_json)
  end
end





# sponsored_bills.json


desc "store sponsored bills in database"
task "db:sponsored_bills" do
  # for each file of tweets
  ["db/sponsored_bills_final.json"].each do |file|
    # read the file
    json_file = File.read(file)
    # parse data into JSON
    json_data = JSON.parse(json_file)
    # for each tweet
    json_data.each do |item|
      SponsoredBill.create({mp_id: item['mp_id'], billNumber: item['billNumber'], dateIntroduced: item['dateIntroduced'], descriptionEN: item['descriptionEN']})
    end
  end
end

desc "sponsored_bills into an array"
task "db:sponsored_array" do
  distinct_mp_ids = SponsoredBill.select(:mp_id).distinct.pluck(:mp_id)
  data = []
  distinct_mp_ids.each do |mp_id|
    # binding.pry
    list = SponsoredBill.arr(mp_id)
    amount = SponsoredBill.bill_count(mp_id)
    # binding.pry
    if list[0][:bill] == "False"
       amount = 0
    else
      amount = amount.length
    end
    if !list.empty?
    data.push({
      mp_id: mp_id.to_i,
      sponsored_bills: list,
      tally: amount
    })
   end
  end
  File.open("sponsored_bills_true.json","w") do |f|
    f.write(data.to_json)
  end
end


desc "store voting records in database"
task "db:voting_record" do
  # for each file of tweets
  ["db/voting_record_trial2.json"].each do |file|
    # read the file
    json_file = File.read(file)
    # parse data into JSON
    json_data = JSON.parse(json_file)
    # for each tweet
    json_data.each do |item|
      VotingMpRecord.create({mp_id: item['mp_id'], mp_party: item['mp_party'], mp_name: item['mp_name'], vote: item['vote'], bill_vote: item['bill_vote']})
    end
  end
end


desc "counting votes missed"
task "db:votes_missed" do
  distinct_mp_ids = VotingMpRecord.select(:mp_id).distinct.pluck(:mp_id)
  data = []
  distinct_mp_ids.each do |mp_id|
    score = VotingMpRecord.missed_votes(mp_id)
    # puts score
    data.push({
      mp_id: mp_id,
      score: score
    })
  end
  File.open("vote_score.json","w") do |f|
    f.write(data.to_json)
  end
end


desc "calculate missed vote score"
task "db:calculate_did_not_vote_score" do 
  ["vote_score.json"].each do |file|
   json_file = File.read(file)
    # parse data into JSON
    score_data = JSON.parse(json_file)
    # for each tweet
    # json_data.each do |score|
    # p score_data[0][:score
    # score_array = []
    score_array = score_data.map { |e| e["score"] }
    # binding.pry
    # # p score_array.first
    sum_value = score_array.inject(0){|accum, i| accum + i }
    # puts sum_value
    # mean = (sum_value / score_array.length).to_f.round(2)
    mean = (sum_value / score_array.length).to_f
    # puts mean
    delta_sum = score_array.inject(0){|accum, i| accum +((i-mean)**2) }
    puts delta_sum
    # variance = (delta_sum/(score_array.length)).to_f.round(2)
    variance = (delta_sum/(score_array.length)).to_f
    puts "variance + #{variance}"
    # standard_deviation = (Math.sqrt(variance)).round(2)
    standard_deviation = (Math.sqrt(variance))

    puts "#{standard_deviation} + standard_deviation"
    normalized_scores = []
    score_data.each do |score|
    mp_id = score['mp_id'].to_i
    vote_number = score['score']
      # binding.pry
    new_score = (10-(((((score['score'])/standard_deviation)).abs * 10))).round(1)
    if new_score < 0
      new_score = 0
    end
      # puts score
      normalized_scores.push({
      mp_id: mp_id,
      score: new_score,
      votes_missed: vote_number
    })
    end
    File.open("did_not_vote_score.json","w") do |f|
      f.write(normalized_scores.to_json)
    end
   end
 end


desc "calculating independence"
task "db:independence" do
  # distinct_parties = VotingMpRecord.select(:mp_party).distinct.pluck(:mp_party)
  distinct_vote = VotingMpRecord.select(:bill_vote).distinct.pluck(:bill_vote)
  # binding.pry
  # vote_by_party
  # data = []
  distinct_vote.each do |vote|
     vote_party = VotingMpRecord.vote_by_party(vote)
   end

  #   # puts score
  #   data.push({
  #     mp_id: mp_id,
  #     score: score
  #   })
  # end
  # File.open("vote_score.json","w") do |f|
  #   f.write(data.to_json)
  # end
end


