require 'rubygems'
require 'nokogiri'
require 'open-uri'         

base_url = "http://www.sfmoma.org"

target_url = "http://www.sfmoma.org/exhib_events/calendar?start=20150216&end=20160216&range=day&change-year=2015&category=exhibition"
page = Nokogiri::HTML(open(target_url))

link_array = page.css("a.url").map{ |a| "\<a href\=\"" + base_url +  a['href'] + "\"\>" + a.text + "\<\/a\>"}

puts link_array


# page.css("a.url").each do |event|
# 	puts event.text
# 	hrefs = page.css("a.url").map{ |a| a['href'] if a['href'].match("/exhibitions/")}.compact
	
# ##spits out useable url
# 	hrefs.each do |exhib_url|
# 		puts base_url + exhib_url
# 	end
# end