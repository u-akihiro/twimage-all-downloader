class Twimage
	def set_target_account(account)
		@account = account
		@request_url = "https://twitter.com/#{account}/media"
	end

	def set_request_url(request_url)
		@request_url = request_url
	end

	def fetch()
		#指定されてたURLにリクエストを投げる
		response = send_request()
		#content-typeを取得
		content_type = response['content-type'].split(';')[0]
		
		#HTMLとJSONで処理を分ける
		parser = nil
		if content_type == 'text/html' then
			parser = Parser4HTML.new(@request_url)
		elsif content_type == 'application/json' then
			parser = Parser4JSON.new(@request_url)
		else
			raise Exception, 'content-type error'
		end
		parser.set_account(@account)
		parser.send_request
		result = parser.parse

		return result
	end

	def iterator()
		Twiterator.new(self)
	end

	private
		def send_request()
			uri = URI.parse(@request_url)
			request = Net::HTTP::Get.new(uri.request_uri)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			response = http.request(request)
		end
end