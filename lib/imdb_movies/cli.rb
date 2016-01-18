# CLI Controller

require_relative 'imdb_scraper.rb'
require_relative 'display.rb'

class ImdbMovies::CLI

	attr_accessor :imdb_page, :nav_links, :movie_links

	SKIP_MENU_DISPLAY = ["1", "2", "3", "opening this week", "now playing", "coming soon", "exit", "quit", ""]

	def initialize
		@nav_links, @movie_links = [], []
		@imdb_page = ImdbScraper.new.scrape

		@imdb_page.each{|cat| @nav_links << cat[0][1] }
		@imdb_page.each{|cat| cat[1].movie_links.each{|movie| @movie_links << movie}}
	end

	# Main CLI
	def call
		puts "\nWelcome to IMDB Movies. Here are some current movies: \n\n"

		user_input = nil

		main_menu

		until user_input == "exit" || user_input == "quit"
			puts "\nYou can enter 1-3, a specific movie name, 'menu' or 'exit/quit'."
			print "Input : "

			user_input = gets.strip.downcase
			input(user_input, movie_links)

			# Only displays the menu again if they entered a movie name or 'menu'
			main_menu if !SKIP_MENU_DISPLAY.include?(user_input)
		end

		puts "\n\nThank You for using IMDB Movies."
	end

	# Displays categories (opening this week, now playing, coming soon) 
	def main_menu

		# Displays categories
		@imdb_page.each.with_index(1){|section, index| 
			puts "\n#{index} - #{section[0][0].gsub(/\(\w+\)/, '')}"
			section[1].movie_links[0...5].each{|movie|
				puts "\t\t#{movie[0]}"
			}
			puts "\tEnter '#{index}' to see more."
		}
	end

	# Gets user's input and calls a different navigation methood based on input
	def input(user_input, movie_links)

		case user_input
		when "",  "menu", "exit", "quit"
		when "1", "opening this week"
			Display.new(@imdb_page[0][1]).opening
		when "2", "now playing"
			Display.new(@imdb_page[1][1]).now_playing
		when "3", "coming soon"
			Display.new(@imdb_page[2][1]).coming_soon

		# When movie is entered it calls Display.movie
		# Otherwise it outputs a message.
		else
			# Nil if movie was not found
			movie_link = movie_links.detect { |m| 
				m[0].downcase.include?(user_input) }

			movie_link ? (Display.new().movie(movie_link[1])) : (puts "\nI'm sorry I don't know what you mean.")
		end
	end

end