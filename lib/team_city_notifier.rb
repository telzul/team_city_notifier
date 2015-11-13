require 'rubygems'
require 'bundler/setup'
require 'timers'

require 'team_city_notifier/feed'
require 'team_city_notifier/entry'


module TeamCityNotifier

  def self.config
    @config ||= Config.new
  end

  def self.run
    timers = Timers::Group.new
    feed = TeamCityNotifier::Feed.new(config.host,config.user,config.password)

    feed.check

    timers.every(config.interval) {
      feed.check
    }

    loop { timers.wait }
  end

  class Config
    attr_accessor :user, :password, :host, :interval

    def initialize
      @interval = 60
    end

    def interval
      @interval || 60
    end
  end
end
