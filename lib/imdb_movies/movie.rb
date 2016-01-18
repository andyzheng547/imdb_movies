class Movie
	attr_accessor :url, :name, :movie_rating, :length, :genres, :release_date, :imdb_rating, :description, :directors, :writers, :cast, :trailer_link

	def initialize(url)
		@url = url

		scrape_info
	end

	# Scrape and store info
	def scrape_info
		info = Nokogiri::HTML(open(@url)).css(".article.title-overview")

		@name = info.css("tbody h1.header span[itemprop = 'name']").text.strip
		
		begin
			@movie_rating = info.css(".infobar meta[itemprop = 'contentRating']").attr("content").value.strip
		rescue NoMethodError
		end

		@length = info.css(".infobar time[itemprop = 'duration']").text.strip
		@release_date = info.css("a[title = 'See all release dates']").text.strip.gsub(/\s+/, " ")
		@imdb_rating = info.css(".titlePageSprite.star-box-giga-star").text.strip
		@description = info.css("p[itemprop = 'description']").text.strip

		genres = info.css("span[itemprop = 'genre']")
		@genres = []
		genres.each{|g| @genres << g.text }
		@genres = @genres.join(", ")

		directors = info.css("div[itemprop = 'director'] span[itemprop = 'name']")
		@directors = []
		directors.each{|d| @directors << d.text}

		writers = info.css("div[itemprop = 'creator'] span[itemprop = 'name']")
		@writers = []
		writers.each{|w| @writers << w.text}

		cast = info.css("div[itemprop = 'actors'] span[itemprop = 'name']")
		@cast = []
		cast.each{|c| @cast << c.text}
		
		@trailer_link = trailer
	end

	# Scrapes Youtube search results for first video link
	# 	searches movie name + ' trailer'
	def trailer
		name = @name.downcase.split(/\W+/).join("+")
		youtube_search = "https://www.youtube.com/results?search_query="
		youtube_search_query = Nokogiri::HTML(open(youtube_search + name + "+trailer",  ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
		
		trailer_link = "https://youtube.com" + youtube_search_query.css("#results ol.section-list li ol.item-section li div.yt-lockup-dismissable div.yt-lockup-content h3.yt-lockup-title a").attr("href").value
	end

	def display_info
		puts "\n#{@name}\n\n"
		puts "Movie Rating: \t#{@movie_rating}"
		puts "Length: \t#{@length}"
		puts "Genre: \t\t#{@genres}"
		puts "Release Date: \t#{@release_date}"
		puts "IMDB Rating: \t#{@imdb_rating}/10.0"
		puts "Director(s): \t#{@directors.join(", ")}"
		puts "Writer(s): \t#{@writers.join(", ")}"
		puts "Cast: \t\t#{@cast.join(", ")}"
	end

	def open_trailer
		exec("open #{@trailer_link}")
	end
end
