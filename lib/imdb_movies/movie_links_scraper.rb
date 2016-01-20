  class MovieLinksScraper
		attr_accessor  :url, :movie_names, :movie_links, :opening_week, :upcomming_week

		IMDB = "http://www.imdb.com"

		def initialize(url)
			@url = url
			@movie_names = []
			@movie_links = []
			@opening_week = ""
			@comming_soon_week = ""
		end

		# Gets the links and opening week from IMDB for the movies that are opening up this week
		# The movie names and links to the movies' IMDB pages are returned back to ImdbScraper
		def opening
			doc = Nokogiri::HTML(open(@url))
			movie_links = doc.css(".article .list")[1].css(".list_item h4[itemprop = 'name'] a")
			add_movie_name_and_links(movie_links)

			# Stores the header that is shown on the opening week movies page
			# Example: 'Opening This Week - January 22' is stored
			@opening_week = doc.css(".article .list h3").first.text

			return @movie_names, @movie_links, @opening_week
		end

		# Gets the links from IMDB for the movies that are popular and in theaters now
		# The movie names and links to the movies' IMDB pages are returned back to ImdbScraper
		def now_playing
			doc = Nokogiri::HTML(open(@url))
			movie_links = doc.css("tbody tr td.titleColumn a")
			add_movie_name_and_links(movie_links)

			return @movie_names, @movie_links
		end

		# Gets the links and opening week from IMDB for the movies that are comming up in 2 weeks
		# The movie names and links to the movies' IMDB pages are returned back to ImdbScraper
		def coming_soon
			doc = Nokogiri::HTML(open(@url))
			movie_links = doc.css(".list.detail .list_item h4[itemprop = 'name'] a")
			add_movie_name_and_links(movie_links)

			# Stores the header that is show on the coming soon movies page
			# Example: 'January 29' is stored
			@coming_soon_week = doc.css(".list.detail h4.li_group a").first.text
			return @movie_names, @movie_links, @coming_soon_week
		end

		# Gets an array movie links that were scraped from an IMDB
		# Each movie link has the movie name as the text.
		# We are pushing each movie name and link inside @movie_names and @movie_links
		def add_movie_name_and_links(movie_links)
			# Pulls anchors which are movie names with links to that movie's page on IMDB
			movie_links.each do |link|
				# Gets the movie name from text
				@movie_names << link.text.gsub(/\(\w+\)/, '')
				# Gets the movie's url
				@movie_links << IMDB + link.attr("href")	
			end
		end
end