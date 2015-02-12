require_relative 'Timeline'

if __FILE__ == $0

  STDOUT.sync = true

  if ARGV.length != 1
    puts "Usage: ruby get_tweets.rb <screen_name>"
    exit(1)
  end

  screen_name = ARGV[0]

  # load oauth.properties
  # instantiate Timeline
  # make the request and store tweets in tweets.json

end
