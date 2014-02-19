class Twimage
	def set_request_url(request_url)
		@request_url = request_url
	end

	def fetch()
		html = Nokogiri::HTML(open(@request_url))
		spans = html.xpath('//*[@id="stream-items-id"]/div/span')
		
		image_urls = []
		spans.each do |span|
			image_urls << span.get_attribute('data-resolved-url-small')
		end

		image_ursl
	end

	def iterator()
		Twiterator.new(self)
	end
end