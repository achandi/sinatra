require 'json'
require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
require 'json'
require 'pry'

json_file = File.read('did_not_vote_score.json')

json_data = JSON.parse(json_file)

# puts jsonarray

open('missed_votes_seed.SQL', 'w'){ |item|
  item << "ALTER TABLE members \n"
  # # item << "ADD column votes_missed_tally int \n ;"
  item << "ADD column did_not_vote_score decimal(10,1) \n ;"
  json_data.each do |i|
    item <<  "Update members \n"
    # item <<  "Set votes_missed_tally = cast ('#{i['votes_missed']}' as int) \n"
    item <<  "Set did_not_vote_score = cast ('#{i['score']}' as decimal(10,1))\n"
    item <<  "WHERE members.id = #{i['mp_id']};\n"
  end
}



    # item << "VALUES (\'#{i['twitter_handle']}'\, \'#{i['word_cloud']}'\, \'#{i['favourite_word']}\')\n"

# open_parliament.json


    # item <<  "SET sponsored_bill_tally = cast (#{i['tally']} as int) \n"
