class Twiterator
	def initialize(twimage)
		@twimage = twimage
		@has_next = true
	end

	def has_next?
		@has_next
	end

	def next
		image_urls = @twimage.fetch()
	end
end