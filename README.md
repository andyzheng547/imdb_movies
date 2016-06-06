# Note: No longer up to date with imdb.com

The website made changes in its HTML and CSS and the project no longer scraps the right info. The gem was made a while ago with when I was still learning. There were inconsistencies between the structure on different movie display pages, and it made an attempted update difficult. I did not account for drastic changes when I was first making a web scraping application. I have a much better respect for web apis because of this.

# IMDB Movies

Welcome to IMDB Movies. This is a Ruby gem that works through CLI. It pulls the info for top current and upcoming films on IMDB's website. Use the CLI to navigate and display information about films you are curious about. Want to see the trailer? We can show it to you. [Here is a demo](https://www.youtube.com/watch?v=En9Ew0cdh6U "Imdb_movies demo video").

  * Version 1.0.3 was downloaded about 100 times but open trailer feature only worked for Macs. Did not want to yank for those 100 people.
  * Version 1.0.5 is a working version but code is not readable. Apologies if you were interested in looking at the code.
  * Version 1.0.6 is the same as 1.0.5 in terms of functionality but code structure, design, and variable names were changed to improve readability. Load time is slightly longer though (about 1 sec).

## Usage

When loaded, the movies will display in 3 categories: Opening This Week, Now Playing, and Coming Soon. The CLI works through text input and is not case sensitive.

The program only displays the first 5 movies in each category if available. To see more movies, enter '1' or 'opening this week', '2' or 'now playing' and '3' or 'coming soon'. I personally recommend '1/2/3'.

To display information about a movie that you are interested in, enter the movie name. It can be a section of the full movie name. 
Example: 'Star Wars: The Force Awakens' can be listed with 'star wars'.

After the movie's info is displayed you have the option of watching the Youtube trailer if you are interested. Just enter 'y' or 'yes' when asked.

When you are done, simple type 'exit' or 'quit' to leave the application.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/azheng249/imdb_movies. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

