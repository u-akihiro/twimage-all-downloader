class Download
	def initialize
	end

	def set_download_url(download_url)
		@download_url = download_url
	end

	def set_store_dir(dir_path)
		@dir_path = dir_path
	end

	def down()
		open(make_file_path, 'wb') do |file|
			open(@download_url) do |data|
				file.write(data.read)
			end
		end
	end

	private
		def make_file_path()
			file_name = File.basename(@download_url)
			file_path = @dir_path + file_name
			return file_path
		end
end