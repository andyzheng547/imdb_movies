# CLI Controller
class ImdbMovies::CLI

	attr_accessor :opening_movie_names, :opening_week, :now_playing_movie_names, :coming_soon_movie_names, :coming_soon_week, :all_movie_names, :all_movie_links

	SKIP_MENU_DISPLAY = ["1", "2", "3", "opening this week", "now playing", "coming soon", "exit", "quit", ""]

	def initialize
		
		imdb_movies_info = ImdbScraper.new.scrape

		@opening_movie_names = imdb_movies_info[0]
		@opening_week = imdb_movies_info[1]
		@now_playing_movie_names = imdb_movies_info[2]
		@coming_soon_movie_names = imdb_movies_info[3]
		@coming_soon_week = imdb_movies_info[4]
		@all_movie_names = imdb_movies_info[5]
		@all_movie_links = imdb_movies_info[6]

	end

	# Main CLI
	def call
		puts "\nWelcome to IMDB Movies. Here are some current movies: \n\n"

		user_input = nil

		main_menu

		until user_input == "exit" || user_input == "quit"
			puts "\nYou can enter 1-3, a specific movie name, 'menu' or 'exit/quit'."
			puts "The movie name does not have to be case sensitive to get the info."
			print "\nInput : "

			user_input = gets.strip.downcase.gsub(/[^\w\s]+/, '').squeeze(" ")
			input(user_input)

			# Only displays the menu again if they entered a movie name or 'menu'
			main_menu if !SKIP_MENU_DISPLAY.include?(user_input)
		end

		puts "\nThank You for using IMDB Movies."
	end

	# Displays movie categories (now playing, opening this week, coming soon) as well as first 5 movies if applicable
	def main_menu

		# Displays movies already in theaters
		puts "\n1 - Now Playing"
		@now_playing_movie_names[0...5].each {|movie_name| puts "\t\t#{movie_name}"}
		puts "\tEnter '1' to see more movies that are playing."

		# Displays opening week movies
		puts "\n2 - #{opening_week}"
		@opening_movie_names[0...5].each {|movie_name| puts "\t\t#{movie_name}"}
		puts "\tEnter '2' to see more movies that are opening this week."

		# Displays categories
		puts "\n3 - #{coming_soon_week}"
		@coming_soon_movie_names[0...5].each {|movie_name| puts "\t\t#{movie_name}"}
		puts "\tEnter '3' to see more movies that are coming after this week."
	end

	# Gets user's input and calls a different navigation methood based on input
	def input(user_input)

		case user_input
		when "",  "menu", "exit", "quit"
		when "1", "opening this week"
			display_movie_names(@opening_movie_names)
		when "2", "now playing"
			display_movie_names(@now_playing_movie_names)
		when "3", "coming soon"
			display_movie_names(@coming_soon_movie_names)

		# When movie is found is entered it creates a new instance of Movie from
		else
			# Search inside the @all_movie_names array. If you user input is included inside a movie title then store the index you found it at
			found_movie_index = @all_movie_names.index{|movie_name| movie_name.downcase.gsub(/[^\w\s]+/, '').squeeze(" ").include?(user_input)}

			# Create a new instance of Movie and have it display the info
			# Otherwise show a message saying you're not sure what that was and display the menu again
			if found_movie_index
				movie = Movie.new(@all_movie_links[found_movie_index])
				movie.display_info

				print "\nDo you want to see the trailer on Youtube (Y/N)?  "
				input = gets.strip.downcase
				movie.open_trailer if input == "yes" || input == "y"
			else
				puts "\nI'm sorry I don't know what you mean."
			end
		end
	end

	def display_movie_names(movie_names)
		movie_names.each{|movie_name| puts "\t\t#{movie_name}"}
	end

end