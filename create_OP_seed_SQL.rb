require 'json'
require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
require 'json'
require 'pry'

json_file = File.read('new_score.json')

json_data = JSON.parse(json_file)

# puts jsonarray

open('twitter_seed.SQL', 'w'){ |item|
  item << "ALTER TABLE members \n"
  item << "ADD column twitter_participation_score decimal(10,1) \n;"
  json_data.each do |i|
    item <<  "Update members \n"
    item <<  "Set twitter_participation_score = cast ('#{i['score']}' as decimal(10,1))\n"
    item <<  "WHERE members.id = #{i['mp_id']};\n"
  end
}



    # item << "VALUES (\'#{i['twitter_handle']}'\, \'#{i['word_cloud']}'\, \'#{i['favourite_word']}\')\n"

# open_parliament.json