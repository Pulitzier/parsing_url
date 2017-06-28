require 'curb'
require 'nokogiri'

def parse_page(uri, page)
	url = Curl.get(uri)
	url.perform
	doc = Nokogiri.parse(url.body_str)
	out = doc.xpath("//html//meta/@content", "//html/*/title", "//html/*/a/@href").to_a

	open(page, "w+") { |f|
		f.puts out.join(', ')
	}
end

parse_page("http://google.com", "page.csv")