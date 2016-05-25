require 'json'
require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
require 'json'
require 'pry'

json_file = File.read('open_parliament.json')

json_data = JSON.parse(json_file)

# puts jsonarray

open('open_parliament_seed.SQL', 'w'){ |item|
  json_data.each do |i|
    item << "Update members \n"
    item <<  "Set twitter =  '#{i['twitter_handle']}', wordcloud = '#{i['word_cloud']}', favoriteword = '#{i['favourite_word']}'\n"
    item <<  "WHERE id = #{i['mp_id']};\n"
  end
}



    # item << "VALUES (\'#{i['twitter_handle']}'\, \'#{i['word_cloud']}'\, \'#{i['favourite_word']}\')\n"

# open_parliament.json