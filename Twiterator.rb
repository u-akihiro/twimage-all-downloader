class Twiterator
	def initialize(twimage)
		@twimage = twimage
		@has_next = true
	end

	def has_next?
		@has_next
	end

	def next
		result = @twimage.fetch()
		if result['more'] then
			@has_next = true
			@twimage.set_request_url(result['next_url'])
		else
			@has_next = false
		end

		return result
	end
end