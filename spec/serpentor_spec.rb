require 'spec_helper'

describe Serpentor do
  it 'has a version number' do
    expect(Serpentor::VERSION).not_to be nil
  end

  describe 'configure' do
    it 'sets up the configuration' do
      Serpentor.configure do |c|
        c.keywords = ['keyword']
        c.host = 'sosv.com'
      end

      expect(Serpentor.configuration.keywords).to eq(['keyword'])
      expect(Serpentor.configuration.host).to eq('sosv.com')
    end
  end

  describe 'rank', vcr: true do
    before(:each) do
      Serpentor.configuration = nil
    end

    it 'returns SERP rankings for a configured set of keywords' do
      Serpentor.configure do |c|
        c.keywords = ['sosv', 'sosventures']
        c.host = 'sosv.com'
      end

      results = Serpentor.rank
      expect(results.map(&:keyword)).to eq(['sosv', 'sosventures'])
    end

    it 'returns SERP rankings for specified keywords' do
      Serpentor.configure do |c|
        c.keywords = ['sosv', 'sosventures']
        c.host = 'sosv.com'
      end

      results = Serpentor.rank(keywords: ['hax', 'indiebio'])
      expect(results.map(&:keyword)).to eq(['hax', 'indiebio'])
    end

    it 'raises an argument error if keywords and host are not present' do
      expect {
        Serpentor.rank
      }.to raise_error(ArgumentError)
    end
  end
end
