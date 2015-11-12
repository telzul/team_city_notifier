require 'rubygems'
require 'bundler/setup'
require 'timers'

require 'team_city_notifier/feed'
require 'team_city_notifier/entry'


module TeamCityNotifier
  def self.run
    url = ENV['TEAM_CITY_URL']
    user = ENV['TEAM_CITY_USER']
    password = ENV['TEAM_CITY_PASS']

    timers = Timers::Group.new
    feed = TeamCityNotifier::Feed.new(url,user,password)

    timers.every(60) {
      feed.check
    }

    loop { timers.wait }
  end
end