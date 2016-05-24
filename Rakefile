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
    if new_score > 10
      binding.pry
    end
      # puts score
    #   normalized_scores.push({
    #   mp_id: mp_id,
    #   score: new_score
    # })
    # end
    # File.open("new_score.json","w") do |f|
    #   f.write(normalized_scores.to_json)
    end
   end
 end


