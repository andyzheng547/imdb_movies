require_relative 'movie.rb'
require 'nokogiri'
require 'open-uri'

class MoviesScraper
	attr_accessor :movies

	IMDB = "http://www.imdb.com"

	def initialize(url)
		@movies = []
		@url = url
	end

	def opening
		doc = Nokogiri::HTML(open(url))
		movie_links = doc.css(".article .list.detail.sublist")[1].css(".list_item h4[itemprop = 'name'] a")
		movie_links.each{|m_link| @movies << Movie.new(IMDB + m_link.attr("href").value)}
		@movies
	end

	def now_playing
		doc = Nokogiri::HTML(open(url))
		movie_links = doc.css("tbody tr td.titleColumn a")
		movie_links.each{|m_link| @movies << Movie.new(IMDB + m_link.attr("href").value))}
		@movies
	end

	def coming_soon
		doc = Nokogiri::HTML(open(url))
		movie_links = doc.css(".list.detail .list_item h4[itemprop = 'name'] a")
		movie_links.each{|m_link| @movies << Movie.new(IMDB + m_link.attr("href").value))}
		@movies
	end
end