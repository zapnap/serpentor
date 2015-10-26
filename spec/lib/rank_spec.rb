require 'spec_helper'

describe Serpentor::Rank, vcr: true do
  describe '.check' do
    it 'returns an instance of Rank' do
      rank = Serpentor::Rank.check('SOSV', 'sosv.com')
      expect(rank).to be_a_kind_of(Serpentor::Rank)
    end
  end

  describe 'check' do
    it 'runs a rank check for a specified keyword and host' do
      rank = Serpentor::Rank.new('sosv accelerator', 'sosv.com').check
      expect(rank.value).to eq(1)
      expect(rank.url).to eq('https://sosv.com/accelerators/')
    end
  end

  describe 'requested?' do
    it 'returns true if the request has been run' do
      rank = Serpentor::Rank.new('sosv accelerator', 'sosv.com').check
      expect(rank.requested?).to eq(true)
    end

    it 'returns false if the request has not been run' do
      rank = Serpentor::Rank.new('sosv accelerator', 'sosv.com')
      expect(rank.requested?).to eq(false)
    end
  end

  describe 'ranked?' do
    it 'returns true if we have a ranking' do
      rank = Serpentor::Rank.new('sosv accelerator', 'sosv.com', limit: 8)
      expect(rank.ranked?).to eq(true)
      expect(rank.value).to eq(1)
    end
  end

  describe 'unranked?' do
    it 'returns false if the keyword has no ranking (too low)' do
      rank = Serpentor::Rank.new('cornbread', 'sosv.com', limit: 8)
      expect(rank.ranked?).to eq(false)
      expect(rank.value).to eq(nil)
    end
  end
end
