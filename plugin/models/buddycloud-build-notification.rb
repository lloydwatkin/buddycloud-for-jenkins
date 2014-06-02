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
    
      case @build.native.getResult.to_s
      when 'SUCCESS'
        if @buddycloud_notification.send_success_notifications
          return true
        end
      when 'UNSTABLE'
        if @buddycloud_notification.send_unstable_notifications
          return true
        end
      when 'FAILURE'
        if @buddycloud_notification.send_failure_notifications
          return true
        end
      else
        return false
      end
      
  end
  
  def should_update_status?
    return @buddycloud_notification.send_status_update
  end

  def send_notification

    load_messages
    
    buddycloud = Buddycloud.new api_base_url, username, password, channel

    unless should_update_status?
      buddycloud.send_message notification_message, nil
    else    
      buddycloud.send_message notification_message, status_message 
    end
  end

  private

  [:api_base_url, :username, :password, :channel, :success_message, :unstable_message, :failure_message, :success_status_message, :unstable_status_message, :failure_status_message].each do |field|
    define_method(field) { expand_all field }
  end

  def expand_all(field)
    TokenMacro.expandAll @build.native, @listener.native, @buddycloud_notification.instance_variable_get("@#{field}")
  end

  def load_messages
    case @build.native.getResult.to_s
    when 'SUCCESS'
      notification_message =  success_message
      status_message = success_status_message
    when 'UNSTABLE'
      notification_message = unstable_message
      status_message = unstable_status_message
    when 'FAILURE'
      notification_message = failure_message
      status_message = failure_status_message
    else
      notification_message = ''
      status_message = ''
    end
  end

end
