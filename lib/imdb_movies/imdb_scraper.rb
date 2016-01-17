require 'open-uri'
require 'nokogiri'
require 'pry'

class ImdbScraper

	URL = "http://www.imdb.com"

	attr_accessor :category_info

	def initialize
		@category_info = []
	end

	def scrape
		doc = Nokogiri::HTML(open(URL))
		sections = doc.css("#sidebar  div.aux-content-widget-2")

		categories = []

		sections.each{|s| 
			category = s.css(".widget_header .oneline h3").text
			if category == "Opening This Week" || category == "Now Playing (Box Office)" || category == "Coming Soon"
				link = URL + s.css(".seemore a").attr("href").value if category != ""
			end

			movies_titles = s.css(".widget_content .title a")
			movies = []
			movies_titles[0...3].each{|m| movies << m.text}

			# Only save parts with movies
			# IMDB's site uses the same classes for every sidebar div
			# No ids to differentiate movies from social in sidebar
			if category == "Opening This Week" || category == "Now Playing (Box Office)" || category == "Coming Soon"
				categories.push([category, movies, link])			
			end
		}
		categories
	end

end
