class Parser
	def initialize(url)
		@url = url
	end

	def set_account(account)
		@account = account
	end

	def send_request()
		uri = URI.parse(@url)
		request = Net::HTTP::Get.new(uri.request_uri)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		@response = http.request(request)
	end

	private
		def get_image_urls(spans)
			result = {'image_urls' => [], 'more' => false, 'next_url' => nil}
			spans.each do |span|
				result['image_urls'] << span.get_attribute('data-resolved-url-small')
			end

			return result
		end
end

class Parser4HTML < Parser
	def parse()
		html = Nokogiri::HTML(@response.body)
		spans = html.xpath('//*[@id="stream-items-id"]/div/span')
		result = get_image_urls spans

		#続きがあるか判定
		max_id = html.xpath('//*[@id="timeline"]/div[2]')[0].get_attribute('data-max-id')
		if max_id.to_i != -1 then
			result['more'] = true
			result['next_url'] = "https://twitter.com/i/profiles/show/#{@account}/media_timeline?include_available_features=1&include_entities=1&max_id=#{max_id}"
		end

		return result
	end
end

class Parser4JSON < Parser
	def parse()
		parsed = JSON.parse(@response.body)
		html = Nokogiri::HTML(parsed['items_html'])
		spans = html.xpath('/html/body/span')
		result = get_image_urls spans

		#続きがあるか判定
		if parsed['has_more_items'] == true then
			max_id = parsed['max_id']
			result['more'] = true
			result['next_url'] = "https://twitter.com/i/profiles/show/#{@account}/media_timeline?include_available_features=1&include_entities=1&max_id=#{max_id}"
		end

		return result
	end
end