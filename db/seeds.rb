# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Line_Item.delete_all
Product.delete_all
# ...
Product.create!(title: 'Seven Mobile Apps in Seven Weeks',
	description:
	%{<p>
		<em>Native Apps, Multiple Platforms</em>
		Answer the question "Can we build this for ALL the devices with a
		resounding YES. This book will help you get there with a real-world
		inroduction to seven platforms, whether you're new to mobile or an
		experienced developer needing to expand your options. Plus, you'll find
		out which cross-platform solution makes the most sense for your needs.
		</p>},
	image_url: 'https://www.lifewire.com/thmb/7pE__VIDaYq0OrolEZ3TBSAusbY=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/dicaprio3-583e33155f9b58d5b19e3a00.jpg',
	price: 26.00)
#...
User.delete_all

User.create!(name: 'Eric'
	password: 'test')