$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'serpentor'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
  c.configure_rspec_metadata!
end
