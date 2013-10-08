require 'xmlsimple'
require 'net/http'
#module Wservices
module Post
  def post_request(method)
    time =  Time.now.to_i.to_s
    hash_method = method.split('&').first
    username = @username
    password = @password
    hash = Digest::SHA1.hexdigest(password + time + hash_method)
    uri = URI.parse("https://staging.carnextdoor.com.au/webservices/index.php/WSUser/WSRest?action=" + method + "&user=" + username + "&hash=" + hash + "&time=" + time + "&billcode=mobile")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)

    response = http.request(request)
    hash = XmlSimple.xml_in(response.body, { 'KeyAttr' => 'name'})
  end
end