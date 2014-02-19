class Twimage
	def set_request_url(request_url)
		@request_url = request_url
	end

	def fetch()
		uri = URI.parse(@request_url)
		request = Net::HTTP::Get.new(uri.request_url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		response = http.request(request)

		#content-typeを取得
		content_type = response['content-type'].split(';')[0]
		#HTMLとJSONで処理を分ける
		if content_type == 'text/html' do
			
		elsif content_type == 'text/json' do
			
		end
	end

	def iterator()
		Twiterator.new(self)
	end

	private content_type?

	end
end