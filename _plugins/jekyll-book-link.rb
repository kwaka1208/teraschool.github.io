module Jekyll
    require 'net/http'
    require 'json'
    
	class RenderBookLink < Liquid::Tag

		def initialize(tag_name, text, tokens)
			super
			url = "http://api.openbd.jp/v1/get?isbn=" + text
			parsed_url = URI.parse(url)
			https = Net::HTTP.new(parsed_url.host, parsed_url.port)
			https.use_ssl = true
			req = Net::HTTP::Get.new(parsed_url.path)
			res = https.request(req)
			json_data = JSON.parse(res.body)
			@output = json_data["data"]["title"]
		end
		
		def render(context)
			"#{ @output }"
		end
	end
end
Liquid::Template.register_tag('book_link', Jekyll::RenderBookLink)
