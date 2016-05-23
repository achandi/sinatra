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
  puts data
end
