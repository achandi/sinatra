require 'json'
require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
require 'json'
require 'pry'

json_file = File.read('sponsored_bills_true.json')

json_data = JSON.parse(json_file)

# puts jsonarray

# puts json_data

open('sponsored_seed_array.SQL', 'w'){ |item|
  # item << "ALTER TABLE members \n"
  # item << "ADD column sponsored_bills text[]; \n"
  # item << "ADD column sponsored_bills json[]; \n"

  # item << "ADD sponsored_bill_tally int; \n"
  json_data.each do |i|
    item <<  "UPDATE members \n"
    # item <<  "SET sponsored_bills = ARRAY#{i['sponsored_bills']}\n"
    item <<  "SET sponsored_bill_tally = cast (#{i['tally']} as int) \n"
    item <<  "WHERE members.id = #{i['mp_id']}; \n"
  end
}

