require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json' 


##Create list of URLs
def urlList
	##The list of URLs we will be running through
	$url_array = [[
		proc{ pullHtml($url_array[0][1]).css("a.url").map{ |a| 
			[a.text , "http://www.sfmoma.org" + a['href']]}},
	"http://www.sfmoma.org/exhib_events/calendar?start=20150216&end=20160216&range=day&change-year=2015&category=exhibition"]]
end

##get html
def pullHtml(target_url)
	return Nokogiri::HTML(open(target_url))
end



def scrape
	x = 0
	array = []
	urlList
	##runs pullHTML
	##uses $url_array but can change to urlList later
	##
	link_array = $url_array[0][0].call
	while x <= (link_array.length - 1)
		##something like this
		puts "name: "  + link_array[x][0] + "\n " + "url: " + link_array[x][1] + "\n"
		x +=1
	end
end

scrape



# This script implements JSON
# It needs to check for dupes
# And rewrite over the whole file -done
# before implemented
#
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
