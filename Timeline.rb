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

  def prepare(param)
    @parser.escape(param.to_s, /[^a-z0-9\-\.\_\~]/i)
  end

  def authorization
    params = { 
      'screen_name' => prepare(@screen_name),
      'count' => prepare('200') }
    header = SimpleOAuth::Header.new("GET", @url, params, @props)
    { 'Authorization' => header.to_s }
  end

  def options
    options = {}
    options[:method]  = :get
    options[:headers] = authorization
    options[:params]  = { screen_name: @screen_name, count: 200 }
    options
  end

  def make_request
    request = Typhoeus::Request.new(@url, options)
    request.run
  end

  def collect
    puts   "REQUESTING   : #{Time.now}"
    response = make_request
    if response.code == 200
      puts "SUCCESS      : #{Time.now}"
      tweets = JSON.parse(response.body)
      puts "#{tweets.size} tweet(s) received."
      yield tweets
    else
      puts "FAILURE      : #{Time.now}"
      puts "Response Code: #{response.code}"
      puts "Response Info: #{response.status_message}"
      exit(1)
    end
  end

  private :authorization, :make_request, :options, :prepare, :url

end
