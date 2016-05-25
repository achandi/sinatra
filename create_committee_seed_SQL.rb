require 'json'
require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
require 'json'
require 'pry'

json_file = File.read('committee.json')

json_data = JSON.parse(json_file)

# puts jsonarray

# puts json_data

open('committee_seed_array.SQL', 'w'){ |item|
  # item << "ALTER TABLE members \n"
  # item << "ADD column committees text[]; \n"
  # item << "ADD committee_tally int; \n"
  json_data.each do |i|
    item <<  "UPDATE members \n"
    # item <<  "SET committees = ARRAY#{i['committees']}\n"
    item <<  "SET committee_tally = cast (#{i['tally']} as int) \n"
    item <<  "WHERE members.id = #{i['mp_id']}; \n"
  end
}

#  cast ('#{i['score']}' as decimal(10,1))


 # item << "Update members \n"
 #    item <<  "Set twitter =  '#{i['twitter_handle']}', wordcloud = '#{i['word_cloud']}', favoriteword = '#{i['favourite_word']}'\n"
 #    item <<  "WHERE id = #{i['mp_id']};\n"


  #  item << "ALTER TABLE members \n"
  # item << "ADD column twitter_participation_score decimal(10,1) \n;"