require 'net/http'
require 'uri'

module ApplicationHelper
  def open(url)
    Net::HTTP.get(URI.parse(url))
  end

  def json_read(path)
    open(request.base_url + path + '.json')
  end
end
