require 'bundler'
require 'open-uri'
require 'net/http'
require 'json'
require './download.rb'
require './Twimage.rb'
require './Twiterator.rb'
require './parser.rb'

Bundler.require

twimage = Twimage.new
twiterator = twimage.iterator

twimage.set_target_account(ARGV[0])
download = Download.new
download.set_store_dir('./image/')
while twiterator.has_next? do
	result = twiterator.next
	result['image_urls'].each do |image_url|
		puts image_url
		download.set_download_url(image_url)
		download.down()
	end
end