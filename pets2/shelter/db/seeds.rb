# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Pet.delete_all
# . . .
Pet.create!(name: 'Cory',
	age: 4,
	description: 
		%{<p>
			This poor little beagle was brought in one night from the freezing cold,
			no owners in sight. Cory is sweet, if a bit shy. Come spend some time with
			this little guy, and he's sure to warm your heart!
		</p>},
	image_url: 'cory.jpg')
# . . .
Pet.create!(name: 'Tabby',
	age: 7,
	description: 
		%{<p>
			This tabby guy was brought in by owners moving out of country, and is looking
			for a home that will give him treats and rub his belly. He's great with kids,
			loves dogs, and is a fully house-trained cat!
		</p>},
	image_url: 'tabby.jpg')
# . . .
Pet.create!(name: 'Bella',
	age: 2,
	description: 
		%{<p>
			Our own shelter had a husky that gave birth to a liter of pretty pups, and they're
			looking for a good home! Athletic and full of energy, Bella is sure to be a great addition
			if you love to run, have kids, or are generally active. Come down and give her ears a rub
			today!
		</p>},
	image_url: 'bella.jpg')
# . . .