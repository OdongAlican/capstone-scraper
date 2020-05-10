require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper
    url = "https://sfbay.craigslist.org/search/hhh?s=0"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    houses = Array.new
    housing_list = parsed_page.css('li.result-row')
    housing_list.each do |housing|
         house = {
             title: housing.css('a.result-title').text,
             price: housing.css('span.result-price')[0].text,
             url: housing.css('a')[0].attributes["href"].value,
             date: housing.css('time.result-date').text
         }
         houses << house
    end
    byebug
end

scraper