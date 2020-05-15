#!/usr/bin/env ruby
require_relative '../lib/scrapper.rb'

sample = Scraper.new('https://sfbay.craigslist.org/search/hhh?s=0')
sample.run
