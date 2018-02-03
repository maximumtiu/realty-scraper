require 'rmagick'
require 'httparty'

class RealtyScraper
  URL = 'https://www.realty-zite.com/AjaxRender.htm?query=params'.freeze
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.freeze

  def photos
    response = HTTParty.get(URL, headers: { 'User-Agent' => USER_AGENT })
    JSON.parse(response.body).dig('images', 'active')
  end

  def save
    photos.each_with_index do |img, index|
      Image.new(index, img).save
    end
  end
end

class Image
  FILE_PATH = '../../../Desktop/your_directory'.freeze # relative path
  attr_reader :id, :json

  def initialize(id, json)
    @id = id
    @json = json
  end

  def url
    json['full'].split("\"")[1]
  end

  def blob
    HTTParty.get(url)
  end

  def body
    Magick::Image.from_blob(blob).first
  end

  def save
    body.write("#{FILE_PATH}/house-#{id}.jpg") unless json.nil?
  end
end

RealtyScraper.new.save
