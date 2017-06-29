require 'curb'
require 'nokogiri'
require 'csv'

def parse_page(uri, page)
	# url = Curl.get(uri)
	# url.perform

	# # File.open(page, 'w') do |f|
	# # 	f.puts url.body_str
	# # end

	# doc = Nokogiri.parse(url.body_str)
	# out = doc.xpath("//body//section[@id='center_column']//a[@class='product-name']/@href").to_a

	# CSV.open(page, 'w') do |row|
	# 	row << [out.join("\n")]
	# end

	# CSV.foreach(page, 'r') do |row|
	# 	product = Curl.get(row)

	url = Curl.get('https://www.petsonic.com/hobbit-alf-barritas-redonda-ternera-para-perros.html')
	url.perform

	# File.open(page, 'w') do |f|
	# 	f.puts url.body_str
	# end

	doc = Nokogiri.parse(url.body_str)
	out = doc.xpath("//body//section[@id='center_column']//a[@class='product-name']/@href").to_a

	CSV.open(page, 'w') do |row|
		row << [out.join(", ")]
	end
end

parse_page("https://www.petsonic.com/snacks-huesos-para-perros/?controllerUri=category&id_category=896&n=221", "s.csv")