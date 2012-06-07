require File.expand_path('../api_credentials', __FILE__)

require 'twitter'
require 'optparse'


Twitter.configure do |config|
  config.consumer_key = TwitterAPICredentials.CONSUMER_KEY
  config.consumer_secret = TwitterAPICredentials.CONSUMER_SECRET
  config.oauth_token = TwitterAPICredentials.OAUTH_TOKEN
  config.oauth_token_secret = TwitterAPICredentials.OAUTH_SECRET
end

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: mass_follow.rb [options]"

  opts.on("-t", "--term TERM", "Search Term") do |term|
    options[:search_term] = term
  end

  opts.on("-s", "--start [NUM]", "Start Page") do |start|
    options[:start_page] = start.to_i
  end

  opts.on("-m", "--max-pages [NUM]", "Max Pages") do |max|
    options[:max_pages] = max.to_i
  end
end.parse!

options[:start_page] = 1 if !options[:start_page]
options[:max_pages] = 10 if !options[:max_pages]

if !options[:search_term]
  puts "You must provide a search term (preceded by the '-t' or '--term' flag)"
  exit
end

page_fetch_count = 0
cur_page = options[:start_page]

while page_fetch_count < options[:max_pages]
  puts "searching '#{options[:search_term]}', page #{cur_page}"

  users = Twitter.user_search(options[:search_term],  :page => cur_page)

  users.each do |user|
    puts "following #{user.attrs["screen_name"]}"
    Twitter.follow(user)
  end

  cur_page += 1
  page_fetch_count += 1
end