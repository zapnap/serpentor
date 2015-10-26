require 'spec_helper'

describe Serpentor::Config do
  it 'can be configured globally' do
    Serpentor.configure do |c|
      c.keywords = ['keyword']
      c.host = 'sosv.com'
    end

    expect(Serpentor.configuration.keywords).to eq(['keyword'])
    expect(Serpentor.configuration.host).to eq('sosv.com')
  end
end
