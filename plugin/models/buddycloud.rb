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
    @url          = @api_base_url + '/channels/' + @channel + '/';
  end

  def send_message(message)
    check_required_fields message: message
    entry = Nokogiri::XML::Builder.new do |xml|
      xml.entry(:xmlns => 'http://www.w3.org/2005/Atom') {
        xml.content message
      }
    end

    headers = { :accept => 'application/xml+atom', :content_type => :xml }
    headers['X-Session-Id'] = @session if defined? @session

    request = RestClient::Request.new(
        :method   => :post,
        :url      => @url + 'posts',
        :user     => @username,
        :password => @password,
        :headers  => headers,
        :payload  => entry.to_xml(:save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
    )
    response = request.execute
    @session = response.headers['X-Session-Id'] if defined? response.headers['X-Session-Id']
    response.code
  end

  private

  def check_required_fields(fields)
    fields.each { |k, v| raise "#{k} cannot be blank." unless v.to_s.strip.length > 0 }
  end

end
