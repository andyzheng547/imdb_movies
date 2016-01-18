require_relative 'movie_links_scraper.rb'

# Scrapes IMDB's main page for movie titles and links on right sidebar
class ImdbScraper

	IMDB = "http://www.imdb.com"

	attr_accessor :category_info

	def initialize
		@category_info = []
	end

	def scrape
		doc = Nokogiri::HTML(open(IMDB))
		sections = doc.css("#sidebar  div.aux-content-widget-2")

		categories = []

		sections.each{|s| 
			category = s.css(".widget_header .oneline h3").text
			begin
				category_link = IMDB + s.css(".seemore a").attr("href").value if category != ""
			rescue NoMethodError
			end

			begin
				category_movies = MovieLinksScraper.new(category_link)
				case category
				when "Opening This Week"
					category_movies.opening
				when "Now Playing (Box Office)"
					category_movies.now_playing
				when "Coming Soon"
					category_movies.coming_soon
				end
				movie_links = category_movies
			rescue NoMethodError
			end

			# Only save parts with movies
			# IMDB's site uses the same classes for every sidebar div
			# No ids to differentiate movies from tv shows and social media
			case category 
			when "Opening This Week", "Now Playing (Box Office)", "Coming Soon"
				categories.push([[category, category_link], movie_links])			
			end
		}

		categories
	end

end

