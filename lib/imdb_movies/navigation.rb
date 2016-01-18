require_relative 'movies_scraper.rb'
require_relative 'movie.rb'

class Navigation

	attr_accessor :url


	def initialize(url)
		@url = url
	end


	def opening
		movies = MoviesScraper.new(@url)
		movies.opening

		puts movies.opening_week + "\n\n"
		movies.movie_links.each{|m| puts "\t\t#{m[0]}"}

	end

	def now_playing
		movies = MoviesScraper.new(@url)
		movies.now_playing

		puts "Now Playing\n\n"
		movies.movie_links.each{|m| puts "\t\t#{m[0]}"}
	end

	def coming_soon
		movies = MoviesScraper.new(@url)
		movies.coming_soon

		puts "Coming Soon - \t" + movies.opening_week + "\n\n"
		movies.movie_links.each{|m| puts "\t\t#{m[0]}"}
	end

	def movie
		movie = Movie.new(@url)
		movie.display_info

		print "\nDo you want to see the trailer for this movie (Y/N):\t"
		user_input = gets.strip.downcase

		movie.open_trailer if user_input == "y" || user_input == "yes"
	end

end