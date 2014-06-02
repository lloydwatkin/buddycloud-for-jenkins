require_relative 'buddycloud-build-notification'

class BuddycloudNotification < Jenkins::Tasks::Publisher

  attr_reader :api_base_url, :username, :password, :channel,
              :send_success_notifications, :success_message,
              :send_unstable_notifications, :unstable_message,
              :send_failure_notifications, :failure_message,
              :send_status_update, :success_status_message, :unstable_status_message, :failure_status_message

  display_name 'buddycloud Notification'

  def initialize(attrs)
    attrs.each { |k, v| instance_variable_set "@#{k}", v }
  end

  def perform(build, launcher, listener)
    n = BuddycloudBuildNotification.new build, listener, self
    return unless n.should_send_notification?
    listener.info 'Sending buddycloud notification...'
    begin
      n.send_notification
      listener.info 'buddycloud notification sent.'
    rescue => e
      listener.error ['An error occurred while sending the buddycloud notification.', e.message, e.backtrace] * "\n"
    end
  end

end
