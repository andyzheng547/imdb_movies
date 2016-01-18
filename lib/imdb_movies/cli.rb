# CLI Controller

require_relative 'imdb_scraper.rb'
require_relative 'navigation.rb'

class ImdbMovies::CLI

	attr_accessor :nav_links, :movie_links

	DONT_DISPLAY_MENU_IF = ["1", "2", "3", "opening this week", "now playing", "coming soon", "exit", "quit", ""]

	def initialize
		@nav_links, @movie_links = [], []
	end

	# Main CLI
	def call
		puts "Welcome to IMDB Movies. Here are some current movies: \n\n"

		user_input = nil

		main_menu

		until user_input == "exit" || user_input == "quit"
			puts "\nYou can enter 1-3, a specific movie name, 'menu' or 'exit/quit'."
			print "Input : "

			user_input = gets.strip.downcase
			input(user_input, nav_links, movie_links)
			main_menu if !DONT_DISPLAY_MENU_IF.include?(user_input)
		end

		puts "\n\nThank You for using IMDB Movies."
	end

	# Displays categories (opening this week, now playing, coming soon) 
	# then returns links to call method so that input method can use them
	def main_menu
		# Gets array from ImdbScraper in this format:
		#		[	array containing the category and link to see more movies on IMDB,
		#			array of arrays each containing a movie title and
		#			the link to that movies IMDB pages 		
		# 		]
		imdb_main = ImdbScraper.new.scrape

		# Displays categories
		imdb_main[0...5].each.with_index(1){|section, index| 
			puts "\n#{index} - #{section[0][0].gsub(/\(\w+\)/, '')}"
			section[1].each{|movie|
				puts "\t\t#{movie[0]}"
			}
			puts "\tEnter '#{index}' to see more."
		}

		# nav_links array contains links to pages to see more movies
		# movie_links array contains arrays with a movie title and a link to that movie on IMDB
		imdb_main.each{|cat| @nav_links << cat[0][1] }
		imdb_main.each{|cat| cat[1].each{|movie| @movie_links << movie}}
	end


	# Gets user's input and calls a different navigation methood based on input
	def input(user_input, nav_links, movie_links)
		case user_input
		when "",  "menu", "exit", "quit"
			return 
		when "1", "opening this week"
			Navigation.new(nav_links[0]).opening
		when "2", "now playing"
			Navigation.new(nav_links[1]).now_playing
		when "3", "coming soon"
			Navigation.new(nav_links[2]).coming_soon

		# When movie is entered it calls Navigation.movie
		# Otherwise it outputs a message.
		else
			# Nil if movie was not found
			movie_link = movie_links.detect { |m| 
				m[0].downcase.include?(user_input) }

			if movie_link
				Navigation.new(movie_link[1]).movie
			else
				puts "\nI'm sorry I don't know what you mean."
			end
		end
	end

end