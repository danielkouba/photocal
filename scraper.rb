require 'rubygems'
#retrive and parse website data
require 'nokogiri'
#deal with website data like a local file
require 'open-uri'
#prepare website data to be displayed
require 'json' 


##-----------------------------------------------
## Website Data Gathering
##-----------------------------------------------

def pullHtml(target_url)
	return Nokogiri::HTML(open(target_url))
end

def scrape
	pageHash = []
	link_array = sfmoma_info
	link_array += rayko_info
	
	x = 0
	while x <= (link_array.length - 1)
		pageHash << {"name" => "#{link_array[x][0]}", "url" => "#{link_array[x][1]}", "date" => "#{link_array[x][2]}"}
		x += 1
	end

	return pageHash
end


##-----------------------------------------------
## File Handling
##-----------------------------------------------

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


##-----------------------------------------------
## PROFILES
##-----------------------------------------------

def rayko_info
	url = "http://raykophotocenter.com/current-show-b"
	rayko = pullHtml(url)
	raykoArray = []
	raykoArray << rayko.css("h1.entry-title a").map{ |a| a.text} 
	raykoArray << rayko.css("h1.entry-title a").map{ |a| "www.raykophotocenter.com" + a['href']}
	raykoArray << [rayko.css("div h3 strong").text[21...47]] #this is not future proof
	return [raykoArray.flatten] 
end	

def sfmoma_info
	url = "http://www.sfmoma.org/exhib_events/calendar?start=20150216&end=20160216&range=day&change-year=2015&category=exhibition"
	sfmoma = pullHtml(url)
	sfmomaArray = []
	# array[0].insert(1, "")
	sfmomaArray << sfmoma.css("a.url").map{ |a| [a.text , "www.sfmoma.org" + a['href'] ]}
	sfmomaArray = sfmomaArray[0] #this is a dirty fix but this is taking too long
	return sfmomaArray
end


##-----------------------------------------------
## Execute Script
##-----------------------------------------------

readFile