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
["db/tweets1.json", "db/tweets2.json", "db/tweets3.json"].each do |file| 
json_file = File.read(file)
json_data = JSON.parse(json_file) 
  json_data.each do |tweet|
    puts tweet
   Tweet.create(mp_id: tweet['mp_id'], text: tweet['text'], quoted_status: tweet['quoted_status'])
 end
end
end

desc "calculate scores"
task "db:calculatescore" do
  distinct_mps = Tweet.select(:mp_id).distinct
  # binding.pry
  hash = []
  distinct_mps.each do |mp|
    score = Tweet.score(mp)
    # binding.pry
    hash.push ({
      "mp_id": mp,
      "score": score
    })
 end
puts hash
end


# [{mpid: 12412, score: 0.53},{mpid: 43113,score: 0.9}…]