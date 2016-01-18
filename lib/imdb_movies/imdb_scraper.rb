require_relative 'movies_scraper.rb'

# Scrapes IMDB's main page for movie titles and links on right sidebar
class ImdbScraper

	URL = "http://www.imdb.com"

	attr_accessor :category_info

	def initialize
		@category_info = []
	end

	def scrape
		doc = Nokogiri::HTML(open(URL))
		sections = doc.css("#sidebar  div.aux-content-widget-2")

		categories = []

		sections.each{|s| 
			category = s.css(".widget_header .oneline h3").text
			begin
				category_link = URL + s.css(".seemore a").attr("href").value if category != ""
			rescue NoMethodError
			end

			begin
				category_movies = MoviesScraper.new(category_link)
				case category
				when "Opening This Week"
					category_movies.opening
				when "Now Playing (Box Office)"
					category_movies.now_playing
				when "Coming Soon"
					category_movies.coming_soon
				end
				movies = category_movies
			rescue NoMethodError
			end

			# Only save parts with movies
			# IMDB's site uses the same classes for every sidebar div
			# No ids to differentiate movies from social in sidebar
			if category == "Opening This Week" || category == "Now Playing (Box Office)" || category == "Coming Soon"
				categories.push([[category, category_link], movies])			
			end
		}
		categories
	end

end

