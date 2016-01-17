require 'nokogiri'
require 'open-uri'
require 'openssl'

class Movie
	attr_accessor :url, :name, :movie_rating, :length, :genres, :release_date, :imdb_rating, :description, :directors, :writers, :cast, :trailer_link

	def initialize(url)
		@url = url

		scrape_info
	end


	def scrape_info
		info = Nokogiri::HTML(open(@url)).css(".article.title-overview")

		@name = info.css("tbody h1.header span[itemprop = 'name']").text
		@movie_rating = info.css(".infobar meta[itemprop = 'contentRating']").attr("content").value
		@length = info.css(".infobar time[itemprop = 'duration']").text
		@genres = info.css("span[itemprop = 'genre']").text
		@release_date = info.css("a[title = 'See all release dates']").text
		@imdb_rating = info.css(".titlePageSprite.star-box-giga-star").text
		@description = info.css("p[itemprop = 'description']").text
		@directors = info.css("div[itemprop = 'director'] span[itemprop = 'name']").text
		@writers = info.css("div[itemprop = 'creator'] span[itemprop = 'name']").text
		@cast = info.css("div[itemprop = 'actors'] span[itemprop = 'name']")
		@trailer_link = trailer
	end

	def trailer
		name = @name.downcase.split(/\W+/).join("+")
		youtube_search = "https://www.youtube.com/results?search_query="
		youtube_search_query = Nokogiri::HTML(open(youtube_search + name + "+trailer",  ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
		trailer_link = "https://youtube.com" + youtube_search_query.css("#results ol.section-list li ol li div.yt-lockup-content h3.yt-lockup-title a").attr("href").value

	end

	def display_info
		puts @name, @movie_rating, @length, @genres, @release_date, @imdb_rating, @description, @directors, @writers, @cast, @trailer_link
	end
end

star_wars = Movie.new("http://www.imdb.com/title/tt2488496/?ref_=cht_bo_3")
puts star_wars.display_info