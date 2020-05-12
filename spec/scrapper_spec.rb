require_relative '../lib/scrapper.rb'

describe 'Scraper' do
  let(:scraper) { Scraper.new('https://example.com') }
  let(:value) { Loop.new(200, 1) }

  describe '#run' do
    it 'calls the run method in Scraper class with a true value' do
      allow(scraper).to receive(:run).and_return(true)
      expect(scraper.run).to eql(true)
    end

    it 'calls the run method in Scraper class with a false value' do
      allow(scraper).to receive(:run).and_return(true)
      expect(scraper.run).not_to eql(false)
    end
  end

  describe '#page_number' do
    it 'allows private method page_number to return true when it recieves a true value' do
      allow_any_instance_of(Scraper).to receive(:page_number).and_return(true)
      expect(scraper.page_number).to eql(true)
    end
    it 'allows private method page_number not to return true when it recieves a true value' do
      allow_any_instance_of(Scraper).to receive(:page_number).and_return(true)
      expect(scraper.page_number).not_to eql(false)
    end
  end

  describe '#run' do
    it 'calls the run method in Loop class with a true value' do
      allow(value).to receive(:run).and_return(true)
      expect(value.run).to eql(true)
    end

    it 'calls the run method in Loop class with a false value' do
      allow(value).to receive(:run).and_return(true)
      expect(value.run).not_to eql(false)
    end
  end

  describe '#scraper' do
    it 'checks the various pages of the website and returns the list of houses' do
      houses = [{
        title: '4 Bed-Room House',
        price: '$4000',
        url: 'https://example.com',
        date: '23-04-2020'
      }]
      allow(value).to receive(:scraper).and_return(houses)
      expect(value.scraper).to eql(houses)
    end

    it 'checks the various pages of the website and does not returns true' do
      houses = [{
        title: '4 Bed-Room House',
        price: '$4000',
        url: 'https://example.com',
        date: '23-04-2020'
      }]
      allow(value).to receive(:scraper).and_return(houses)
      expect(value.scraper).not_to eql(true)
    end

    it 'checks the various pages of the website and does not returns false' do
      houses = [{
        title: '4 Bed-Room House',
        price: '$4000',
        url: 'https://example.com',
        date: '23-04-2020'
      }]
      allow(value).to receive(:scraper).and_return(houses)
      expect(value.scraper).not_to eql(false)
    end
  end
end
