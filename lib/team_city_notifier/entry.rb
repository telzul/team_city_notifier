require 'libnotify'

module TeamCityNotifier
  class Entry
    attr_reader :title, :created_at, :link, :status


    def initialize(raw_data)
      @title = raw_data['title']
      @created_at = Time.parse(raw_data['date'])
      @link = raw_data['link']['href']
      @status = raw_data['creator'] == 'Successful Build' ? :succes : :failed
    end

    def send_notification
      n = Libnotify.new do |notify|
        notify.summary    = notification_title
        notify.body       = notification_body
        notify.timeout    = 10         # 1.5 (s), 1000 (ms), "2", nil, false
        notify.urgency    = failed? ? :critical : :normal   # :low, :normal, :critical
        notify.transient  = true        # default false - keep the notifications around after display
        notify.icon_path  = notification_icon
      end

      n.show!
    end

    def failed?
      status==:failed
    end

    private

    def notification_title
      if failed?
        "<h2 style=\"color:#e61919\">Build Failed!</h1>"
      else
        "<h2 style=\"color:#009933\">Build Successfull!</h1>"
      end
    end

    def notification_body
      title + "<br><br><a href=\"#{link}\" style=\"color:#aaaaaa;\">Go to TeamCity</a>"
    end

    def notification_icon
      script_folder = File.dirname(__FILE__)
      File.join(script_folder,"..","..","icons",failed? ? "failure.svg" : "success.svg")
    end

  end
end