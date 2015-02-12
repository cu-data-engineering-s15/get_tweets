require 'bundler/setup'

require 'json'
require 'simple_oauth'
require 'typhoeus'

class Timeline

  def initialize(args)
    @parser      = URI::Parser.new
    @props       = args.fetch(:props)
    @screen_name = args.fetch(:screen_name)
    @url         = url
  end

  def url
    'https://api.twitter.com/1.1/statuses/user_timeline.json'
  end

  private :url

end
