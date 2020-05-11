# frozen_string_literal: true

require 'nokogiri'
require 'byebug'
require 'open-uri'

class Scraper
  def run
    url = 'https://sfbay.craigslist.org/search/hhh?s=0'
    document = ::OpenURI.open_uri(url)
    content = document.read
    parsed_page = Nokogiri::HTML(content)
    housing_list = parsed_page.css('li.result-row')
    page_number(parsed_page, housing_list)
  end

  def page_number(parsed_page, housing_list)
    page = 0
    per_page = housing_list.count
    total = parsed_page.css('span.totalcount')[0].text.to_i
    sample = Loop.new(total, page)
    sample.scraper
    last_page = (total.to_f / per_page).round
  end
end

class Loop < Scraper
  attr_reader :total, :page
  def initialize(total, page)
    @total = total
    @page = page
  end

  def run
    pagination_url = "https://sfbay.craigslist.org/search/hhh?s=#{@page}"
      puts pagination_url
      puts "Page Number: #{@page}"
      puts ''
      document = ::OpenURI.open_uri(pagination_url)
      content = document.read
      pagination_parsed_page = Nokogiri::HTML(content)
      pagination_parsed_page.css('li.result-row')
  end

  def scraper
    houses = []
    while @page <= @total

      pagination_housing_list = run

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
      @page += 120
      break if @page == @total
    end
    byebug
  end
end

sample = Scraper.new
sample.run
