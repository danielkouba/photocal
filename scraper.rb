require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json' 


##Create list of URLs
def urlList
	##The list of URLs we will be running through
	$url_array = [
		#sfmoma
			"http://www.sfmoma.org/exhib_events/calendar?start=20150216&end=20160216&range=day&change-year=2015&category=exhibition",
		#rayko
			"http://raykophotocenter.com/current-show-b"
	]	
end

##get html
def pullHtml(target_url)
	return Nokogiri::HTML(open(target_url))
end



def scrape
	pageHash = []
	urlList
	
	#sfmoma
	sfmoma = pullHtml($url_array[0])
	link_array = sfmoma.css("a.url").map{ |a| [a.text , "www.sfmoma.org" + a['href'] ]}
	#rayko
	rayko = pullHtml($url_array[1])
	raykoArray = []
	raykoArray << rayko.css("h1.entry-title a").map{ |a| a.text} 
	raykoArray << rayko.css("h1.entry-title a").map{ |a| "www.raykophotocenter.com" + a['href']}
	raykoArray << [rayko.css("div h3 strong").text[21...47]] #this is not future proof

	link_array += [raykoArray.flatten] 
	
	x = 0
	while x <= (link_array.length - 1)
		pageHash << {"name" => "#{link_array[x][0]}", "url" => "#{link_array[x][1]}", "date" => "#{link_array[x][2]}"}
		x += 1
	end

	return pageHash
end

def readFile
	file = File.open("exhibits.json", "r+")
	rb_hash = JSON.parse(file.read)
	scrape.each do |h|
		rb_hash << h
	end
	rb_hash.uniq!
	$rb_json = JSON.pretty_generate(rb_hash)
	file.close
	writeFile
end

def writeFile
	file = File.open("exhibits.json", "w")
	file.write($rb_json)
	file.close
end

readFile