# frozen_string_literal: true

require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper
  url = 'https://sfbay.craigslist.org/search/hhh?s=0'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  houses = []
  housing_list = parsed_page.css('li.result-row')

  page = 0
  per_page = housing_list.count
  total = parsed_page.css('span.totalcount')[0].text.to_i
  last_page = (total.to_f / per_page).round

  while page <= total
    pagination_url = "https://sfbay.craigslist.org/search/hhh?s=#{page}"
    puts pagination_url
    puts "Page: #{page}"
    puts ''
    pagination_unparsed_page = HTTParty.get(pagination_url)
    pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page)
    pagination_housing_list = pagination_parsed_page.css('li.result-row')

    pagination_housing_list.each do |housing|
      house = {
        title: housing.css('a.result-title').text,
        price: housing.css('span.result-price')[0].text,
        url: housing.css('a')[0].attributes['href'].value,
        date: housing.css('time.result-date').text
      }
      houses << house
      puts "Added #{house[:title]}"
      puts ''
    end
    page += 120
  end
  byebug
end

scraper
