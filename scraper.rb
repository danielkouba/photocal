require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json' 


##Create list of URLs
def urlList
	##The list of URLs we will be running through
	$url_array = [[
		proc{ pullHtml($url_array[0][1]).css("a.url").map{ |a| 
			[a.text , "www.sfmoma.org" + a['href']]}},
	"http://www.sfmoma.org/exhib_events/calendar?start=20150216&end=20160216&range=day&change-year=2015&category=exhibition"]]
end

##get html
def pullHtml(target_url)
	return Nokogiri::HTML(open(target_url))
end



def scrape
	x = 0
	array = []
	$pageHash = []
	urlList
	##runs pullHTML
	##uses $url_array but can change to urlList later
	##
	link_array = $url_array[0][0].call
	while x <= (link_array.length - 1)
		##something like this
		$pageHash << {"name" => "#{link_array[x][0]}", "url" => "#{link_array[x][1]}"}
		x +=1
	end
end




# This script implements JSON
# It needs to check for dupes
# And rewrite over the whole file -done
# before implemented
#
def readFile
	file = File.open("exhibits.json", "r+")
	$rb_hash = JSON.parse(file.read)
	$pageHash.each do |h|
		$rb_hash << h
	end
	$rb_json = JSON.pretty_generate($rb_hash)
	file.close
	writeFile
end

def writeFile
	file = File.open("exhibits.json", "w")
	file.write($rb_json)
	file.close
end

scrape
readFile