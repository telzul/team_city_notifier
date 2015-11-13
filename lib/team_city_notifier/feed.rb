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
        begin
          response = self.class.get(@feed_url,@options)
          raise StandardError.new("Could not connect to TeamCity - status code #{response.code}") unless response.success?
          parse_entries(response.parsed_response)

        rescue StandardError => e
          print_error(e)
          exit(1)
        end

      end

      def parse_entries(raw_data)
        raw_data['feed']['entry'].map {|entry_data| Entry.new(entry_data)}.reject {|e| e.created_at <= @last_update}
      end

      def print_error(e)
        n = Libnotify.new do |notify|
          notify.summary    = "TeamCityNotifier Error"
          notify.body       = e.message
          notify.timeout    = 10         # 1.5 (s), 1000 (ms), "2", nil, false
          notify.urgency    = :critical   # :low, :normal, :critical
          notify.transient  = true        # default false - keep the notifications around after display
          notify.icon_path  = File.join(File.dirname(__FILE__) ,"..","..","icons","failure.svg")
        end
        n.show!
      end
  end
end
