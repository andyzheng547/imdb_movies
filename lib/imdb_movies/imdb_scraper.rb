# Scrapes IMDB's main page for movie titles and links on right sidebar
  class ImdbScraper

	IMDB = "http://www.imdb.com"

	attr_accessor :opening_movie_names, :opening_movie_links, :opening_week, :now_playing_movie_names, :now_playing_movie_links, :coming_soon_movie_names, :coming_soon_movie_links, :coming_soon_week, :all_movie_names, :all_movie_links

	def initialize
		@opening_movie_names = []
		@opening_movie_links = []
		@opening_week = ""
		@now_playing_movie_names = []
		@now_playing_movie_links = []
		@coming_soon_movie_names = []
		@coming_soon_movie_links = []
		@coming_soon_week = ""
		@all_movie_names = []
		@all_movie_links = []
	end

	def scrape
		doc = Nokogiri::HTML(open(IMDB))

		# Gets the HTML for the divs on the sidebar
		sections = doc.css("#sidebar  div.aux-content-widget-2")

		# For each section, it gets and stores the movie names, links and the week if applicable
		sections.each do |section| 

			# Stores the category header in category. 
			# We only want the movies, not the television or social media
			category =  section.css(".widget_header .oneline h3").text

			case category
				when "Opening This Week", "Now Playing (Box Office)", "Coming Soon"

					# Gets the see more url so that MovieLinksScraper knows where to get the movie links from
					category_link = IMDB + section.css(".seemore a").attr("href").value

					# Looks inside the linked page to get the movies for that category
					# Stores the array of movie names and links inside @movie_names and @movie_links to be flattened later
					category_movies = MovieLinksScraper.new(category_link)
					case category
						when "Opening This Week"
							@opening_movie_names, @opening_movie_links, @opening_week = category_movies.opening
						when "Now Playing (Box Office)"
							@now_playing_movie_names, @now_playing_movie_links = category_movies.now_playing
						when "Coming Soon"
							@coming_soon_movie_names, @coming_soon_movie_links, @coming_soon_week = category_movies.coming_soon
							@coming_soon_week = "Coming Soon - Week of " + @coming_soon_week
					end

				end
			end

			@all_movie_names = [@opening_movie_names, @now_playing_movie_names, @coming_soon_movie_names].flatten
			@all_movie_links = [@opening_movie_links, @now_playing_movie_links, @coming_soon_movie_links].flatten

			# Returning all the categories, movie names and links to the CLI to store
			# We are sending back the category's link so that the Display class can look inside that page and get each movie name
			# The CLI will not know what movies belong in which category, so it doesn't know how to display them
			# The CLI calls the Display class so it can search for 

			return @opening_movie_names, @opening_week, @now_playing_movie_names, @coming_soon_movie_names, @coming_soon_week, @all_movie_names, @all_movie_links
	end

end

