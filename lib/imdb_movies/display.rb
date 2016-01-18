require_relative 'movie_links_scraper.rb'
require_relative 'movie.rb'

class Display

	attr_accessor :links

	def initialize(links = nil)
		@links = links
	end

	def opening
		puts @links.opening_week + "\n\n"
		@links.movie_links.each{|m| puts "\t\t#{m[0]}"}

	end

	def now_playing
		puts "Now Playing\n\n"
		@links.movie_links.each{|m| puts "\t\t#{m[0]}"}	
	end

	def coming_soon
		puts "Coming Soon - \t" + @links.opening_week + "\n\n"
		@links.movie_links.each{|m| puts "\t\t#{m[0]}"}	
	end

	def movie(movie_url)
		movie = Movie.new(movie_url)
		movie.display_info

		print "\nDo you want to see the trailer for this movie (Y/N):\t"
		user_input = gets.strip.downcase

		movie.open_trailer if user_input == "y" || user_input == "yes"
	end

end