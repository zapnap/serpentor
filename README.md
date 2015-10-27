# Serpentor

Simple utility to check search engine result rankings for a given set of keywords.
Right now only Google search is supported.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'serpentor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serpentor

## Usage

Run an individual keyword test:

```ruby
rank = Serpentor::Rank.check('SOSV', 'sosv.com')
puts "Rank is #{rank.value} (#{rank.url})"
```

Or configure a bulk keyword test:

```ruby
config = Serpentor.configure do |config|
  config.keywords = ["keyword1", "keyword2"]
  config.host = "my-site.com"
  config.limit = 10 # only care if result is on first page
end

results = Serpentor.rank
results.each do |res|
  puts "Rank for '#{res.keyword}' is #{res.rank || 'N/A'} (#{res.url})"
end
```

The first 5 pages (50 results) are checked by default. You can further limit
that number, for example, if you only care about first page results.

### Data Store Support

Want to save your keyword data to a spreadsheet? Serpentor can do that too.
[Watch Serpentor command](https://www.youtube.com/watch?v=kz7h1KN_EFg) Google Sheets to do its bidding:

```ruby
Serpentor.configure do |config|
  config.limit = 50
  config.keywords = File.read('keywords.txt').split("\n")
  config.host = 'sosv.com'
  config.data_store_type = 'google_sheet'
  config.data_store_id = 'id-for-an-existing-google-spreadsheet'
  config.client_id = 'your-google-oauth-client-id'
  config.client_secret = 'your-google-oauth-client-secret'
end

Serpentor.rank
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/serpentor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
