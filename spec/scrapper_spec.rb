# frozen_string_literal: true

require_relative '../lib/scrapper.rb'

describe 'Scraper' do
  let(:scraper) { Scraper.new('https://example.com') }
  let(:loop) { Loop.new(200, 1) }
  
  describe '#run' do
    it 'calls the run method with a true value' do
      allow(scraper).to receive(:run).and_return(true)
      expect(scraper.run).to eql(true)
    end

    it 'calls the run method with a false value' do
      allow(scraper).to receive(:run).and_return(true)
      expect(scraper.run).not_to eql(false)
    end
  end
end

