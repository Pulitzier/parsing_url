require 'curb'
require 'nokogiri'
require 'csv'

def parse_page(uri, page)
	# Get the main page
	url = Curl.get(uri)
	url.perform

	doc = Nokogiri.parse(url.body_str)
	out = doc.xpath("//body//section[@id='center_column']//a[@class='product-name']/@href").to_s
	# Find neaded links to products and place them in one file
	CSV.open("links.csv", 'w') do |row|
		out.each_line('html'){|s| 
			row << [s]
		}
	end
	# Loop through each link and get information for product
	CSV.foreach("links.csv", 'r+') do |l|
		 # When call each row it is returned in array, like [".....row....", so need to fetch values]
		product = Curl.get(l.fetch(0))
		product.perform

		# doc = Nokogiri.parse(product.body_str)
		# product_w = doc.xpath("//body//section[@id='center_column']//span[@class='attribute_name']/text()")
		# product_p = doc.xpath("//body//section[@id='center_column']//span[@class='attribute_price']/text()")
			
		# out = doc.xpath("//body//section[@id='center_column']//h1/text()")
		# pic = doc.xpath("//body//section[@id='center_column']//img[@id='bigpic']/@src")
		# CSV.open(page, 'a') do |line|
		# 	i = 0
		# 	while i < product_w.length
		# 		line << [out.text.strip + ' - ' + product_w[i].text.strip, product_p[i].text.strip, pic.text.strip]
		# 		i += 1
		# 	end
		# end

	end

end

parse_page("https://www.petsonic.com/snacks-huesos-para-perros/?controllerUri=category&id_category=896&n=221", "output_info.csv")