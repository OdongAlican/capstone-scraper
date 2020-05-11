# frozen_string_literal: true

require_relative '../lib/scrapper.rb'

describe 'Scraper' do
  let(:scraper) { Scraper.new('https://example.com') }
  let(:loop) { Loop.new(200, 1) }
  describe '#run' do
    it 'calls the page_number method passing arguments' do
      expect(scraper.run).to recieve(last_page)
    end
  end
end

# describe Calculator do
#     describe "#add" do
#       it "returns the sum of two numbers" do
#         calculator = Calculator.new
#         expect(calculator.add(5, 2)).to eql(7)
#       end
#     end
#   end
