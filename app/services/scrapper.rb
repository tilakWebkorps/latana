require 'open-uri'
require 'net/http'
require 'nokogiri'

class Scrapper
  def initialize(url)
    @url = url
  end

  def scrap
    uri = URI.parse(@url)

    response = Net::HTTP.get_response(uri)
    html = response.body
    doc = Nokogiri::HTML(html)
    description = []
    doc.css('tr').map do |tr|
      file = tr.css('td a').text
      data = tr.css('td').map do |date|
        date.text
      end
      if !data.empty? and file.include?('tar.gz')
        date = data.reject! { |link| !link.include?(':') }
        description.push({
          file: file,
          date: date[0]
        })
      end
    end
    description
  end
end