require_relative 'movies_scraper.rb'
require_relative 'movie.rb'

class Navigation

	attr_accessor :url


	def initialize(url)
		@url = url
	end


	def opening
		movies = MoviesScraper.new(url).opening
	end

	def now_playing
		movies = MoviesScraper.new(url).now_playing
	end

	def coming_soon
		movies = MoviesScraper.new(url).coming_soon
	end

	def movie
		
	end

end