require 'json'
require_relative 'Timeline'

def load_props
  input = File.open('oauth.properties')
  JSON.parse(input.read)
end

def convert_props(input)
  props = {}
  input.keys.each do |key|
    props[key.to_sym] = input[key]
  end
  props
end

if __FILE__ == $0

  STDOUT.sync = true

  if ARGV.length != 1
    puts "Usage: ruby get_tweets.rb <screen_name>"
    exit(1)
  end

  screen_name = ARGV[0]
  props       = convert_props(load_props)

  args    = {props: props, screen_name: screen_name } 
  twitter = Timeline.new(args)

  puts "Collecting 200 most recent tweets for '#{screen_name}'"

  twitter.collect do |tweets|
    File.open('tweets.json', 'w') do |f|
      tweets.each do |tweet|
        f.puts "#{tweet.to_json}\n"
      end
    end
  end

  puts "DONE."

end
