require 'httparty'

module TeamCityNotifier
  class Feed
    include HTTParty


    def initialize(feed_url,user,password)
      @feed_url = feed_url
      @last_update = Time.now
      @options = {basic_auth: {username: user, password: password}}
    end

    def check
      entries = fetch_feed
      entries.each { |entry| entry.send_notification }

      @last_update = entries.map(&:created_at).max if entries.any?
    end


    private
      def fetch_feed
        response = self.class.get(@feed_url,@options)

        if response.success?
          parse_entries(response.parsed_response)
        else
          []
        end
      end

      def parse_entries(raw_data)
        if Time.parse(raw_data['feed']['updated']) > @last_update
          raw_data['feed']['entry'].map {|raw_data| Entry.new(raw_data)}.reject {|e| e.created_at <= @last_update}
        else
          []
        end
      end
  end
end