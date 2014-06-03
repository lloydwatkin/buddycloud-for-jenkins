require 'rest-client'
require 'nokogiri'
require_relative 'buffered-io-patch'

class Buddycloud

  def initialize(api_base_url, username, password, channel)
    check_required_fields api_base_url: api_base_url, username: username, password: password, channel: channel
    @api_base_url = api_base_url
    @username     = username
    @password     = password
    @channel      = channel
    @url          = @api_base_url + '/' + @channel + '/content/';
  end

  def send_message(message, status_message)
    check_required_fields message: message
    entry        = create_entry message
    responseCode = make_request entry, "posts"
    
    if !status_message.nil? && !status_message.empty?
      entry = create_entry status_message
      make_request entry, "status"
    end
    responseCode
  end

  private

  def check_required_fields(fields)
    fields.each { |k, v| raise "#{k} cannot be blank." unless v.to_s.strip.length > 0 }
  end
  
  def make_request(entry, node)
    headers = { :accept => 'application/atom+xml', :content_type => :xml }
    headers['X-Session-Id'] = @session if defined? @session

    request = RestClient::Request.new(
        :method   => :post,
        :url      => @url + node,
        :user     => @username,
        :password => @password,
        :headers  => headers,
        :payload  => entry.to_xml(:save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
    )
    response = request.execute
    @session = response.headers['X-Session-Id'] if defined? response.headers['X-Session-Id']
    response.code
  end
  
  def create_entry(message)
    Nokogiri::XML::Builder.new do |xml|
      xml.entry(:xmlns => 'http://www.w3.org/2005/Atom') {
        xml.content message
      }
    end
  end
    
end
