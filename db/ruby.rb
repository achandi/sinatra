require 'json'
require 'ostruct'
require 'pry'
require 'json'

json_file = File.read('whatever.json')

json_data = JSON.parse(json_file)

array = []
json_data.each do |x|
  puts x["dateIntroduced"][1]["english"]
 # array.push(x["mp_id"], x["dateIntroduced"])

end

# puts array[1][0]["name"]["en"]