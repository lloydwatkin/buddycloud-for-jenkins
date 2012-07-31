require_relative 'buddycloud-build-notification'

class BuddycloudNotification < Jenkins::Tasks::Publisher

  attr_reader :api_base_url, :username, :password, :channel,
              :send_success_notifications, :success_message,
              :send_failure_notifications, :failure_message

  display_name 'Buddycloud Notification'

  def initialize(attrs)
    attrs.each { |k, v| instance_variable_set "@#{k}", v }
  end

  def perform(build, launcher, listener)
    n = BuddycloudBuildNotification.new build, listener, self
    return unless n.should_send_notification?
    listener.info 'Sending Buddycloud notification...'
    begin
      n.send_notification
      listener.info 'Buddycloud notification sent.'
    rescue => e
      listener.error ['An error occurred while sending the Buddycloud notification.', e.message, e.backtrace] * "\n"
    end
  end

end
