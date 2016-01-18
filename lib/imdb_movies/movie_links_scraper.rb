require_relative 'movie.rb'


class MovieLinksScraper
	attr_accessor :movie_links, :url, :opening_week

	IMDB = "http://www.imdb.com"

	def initialize(url)
		# Array of arrays, each with movie name and link
		@movie_links = []

		@url = url
	end

	def opening
		doc = Nokogiri::HTML(open(@url))
		movie_links = doc.css(".article .list")[1].css(".list_item h4[itemprop = 'name'] a")
		begin
			movie_links.each{|m_link| @movie_links.push( [ m_link.text.gsub(/\(\w+\)/, ""), (IMDB + m_link.attr("href")) ] )}
		rescue NoMethodError
		end

		@opening_week = doc.css(".article .list h3").first.text
		@movie_links
	end

	def now_playing
		doc = Nokogiri::HTML(open(@url))
		movie_links = doc.css("tbody tr td.titleColumn a")
		begin
			movie_links.each{|m_link| @movie_links.push( [ m_link.text.gsub(/\(\w+\)/, ""), (IMDB + m_link.attr("href")) ] )}		
		rescue NoMethodError
		end
		@movie_links
	end

	def coming_soon
		doc = Nokogiri::HTML(open(@url))
		movie_links = doc.css(".list.detail .list_item h4[itemprop = 'name'] a")
		begin
			movie_links.each{|m_link| @movie_links.push( [ m_link.text.gsub(/\(\w+\)/, ""), (IMDB + m_link.attr("href")) ] )}		
		rescue NoMethodError
		end

		@opening_week = doc.css(".list.detail h4.li_group a").first.text
		@movie_links
	end
end