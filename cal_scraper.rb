require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'      

base_url = "http://www.sfmoma.org"

#set target and 
target_url = "http://www.sfmoma.org/exhib_events/calendar?start=20150216&end=20160216&range=day&change-year=2015&category=exhibition"
page = Nokogiri::HTML(open(target_url))

#formats aquired data to be injected into webpage
link_array = page.css("a.url").map{ |a| "\<a href\=\"" + base_url +  a['href'] + "\"\>" + a.text + "\<\/a\	> \<br \/\>"}

# file = File.open("sample.html", "r+")
# page_data = file.read
# file.close

file = File.open("sample.html", "w+")
page_data.gsub!("<!-- insert point -->","<!-- insert point -->#{link_array.join}")
file.write(page_data)
file.close
`open sample.html`

def readFile
	file = File.open("exhibits.json", "r+")
	rb_hash = JSON.parse(file.read)
	rb_hash[0] << { "name" => "Nonsense"}
	rb_json = JSON.pretty_generate(rb_hash)
	file.close
end

def writeFile
	file = File.open("exhibits.json", "w")
	file.write(rb_json)
	file.close
end

