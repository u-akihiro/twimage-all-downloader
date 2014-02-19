require 'bundler'
require 'open-uri'
require 'net/http'
require 'json'
require './download.rb'
require './Twimage.rb'
require './Twierator.rb'

Bundler.require

html = Nokogiri::HTML(open("https://twitter.com/jkhiplove/media"))
spans = html.xpath('//*[@id="stream-items-id"]/div/span')
spans.each do |span|
	image_url = span.get_attribute('data-resolved-url-small')
	puts image_url
	download = Download.new
	download.set_download_url(image_url)
	download.set_store_dir('./image/')
	download.down
end