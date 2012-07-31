require_relative 'buddycloud'
include Java
java_import org.jenkinsci.plugins.tokenmacro.TokenMacro

class BuddycloudBuildNotification

  def initialize(build, listener, buddycloud_notification)
    @build                   = build
    @listener                = listener
    @buddycloud_notification = buddycloud_notification
  end

  def should_send_notification?
    (success? && @buddycloud_notification.send_success_notifications) || (!success? && @buddycloud_notification.send_failure_notifications)
  end
  
  def should_update_status?
    (success? && @buddycloud_notification.send_status_update)
  end

  def send_notification
    message    = success? ? success_message : failure_message
    buddycloud = Buddycloud.new api_base_url, username, password, channel

    unless should_update_status?
      buddycloud.send_message message, nil
    else 
      if success? 
        buddycloud.send_message message, success_status_message
      else
        buddycloud.send_message message, failure_status_message
      end    
    end
  end

  private

  [:api_base_url, :username, :password, :channel, :success_message, :failure_message, :success_status_message, :failure_status_message].each do |field|
    define_method(field) { expand_all field }
  end

  def expand_all(field)
    TokenMacro.expandAll @build.native, @listener.native, @buddycloud_notification.instance_variable_get("@#{field}")
  end

  def success?
    @build.native.getResult.to_s == 'SUCCESS'
  end

end
