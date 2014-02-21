require 'bundler'
require 'open-uri'
require 'net/http'
require 'json'
require './download.rb'
require './Twimage.rb'
require './Twiterator.rb'
require './parser.rb'

Bundler.require

#引数のチェック
if ARGV[0].nil? || ARGV[1].nil? then
	raise Exception, '引数を確認してください'
end

twimage = Twimage.new
twiterator = twimage.iterator

twimage.set_target_account(ARGV[0])
download = Download.new
download.set_store_dir("./image/#{ARGV[1]}/")
while twiterator.has_next? do
	result = twiterator.next
	result['image_urls'].each do |image_url|
		puts image_url
		download.set_download_url(image_url)
		sleep(1)
		download.down()
	end
end