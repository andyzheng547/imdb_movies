# CLI Controller

require_relative 'imdb_scraper.rb'

class ImdbMovies::CLI

	def initialize

	end

	def call
		puts "Welcome to IMDB Movies. Here are some current movies: \n"
		main_menu


	end

	# Gets movies array from ImdbScraper containing:
	# 		category, movie titles and link to see more info 
	def main_menu
		imdb_main = ImdbScraper.new.scrape

		imdb_main.each.with_index(1){|section, index| 
			puts "#{index} - #{section[0]}"
			section[1].each{|movie|
				puts "\t\t#{movie}"
			}
			puts "Enter '#{index}' to get more information."
		}
	end

	def input
		
	end

end