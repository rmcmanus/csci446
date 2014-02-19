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
	age: 5,
	breed: 'Beagle',
	description:
		%{<p>
			This poor guy was found on our doorstep just a few weeks ago, a little malnourished
			but healthy and happy. Loves meeting people, especially kids. Will give kisses for free!
		  </p>},
	habits:
		%{<p>
			Sleeps, a lot!<br>
			Will beg for belly rubs<br>
			Likes to play fetch<br>
			Eats too much if food is left out
			</p>},
	image_url: 'cory.jpg')
# . . .
Pet.create!(name: 'Tabby',
	age: 7,
	breed: 'Tabby Cat',
	description:
		%{<p>
			Older cat that was brought in when her owners couldn't afford to keep her anymore.
			Sweet, loves to play with toys. Especially loves laser pointers, other cats, and dogs!
		  </p>},
	habits:
		%{<p>
			Sleeps, a lot!<br>
			Master of her own universe<br>
			Loves to scratch anything, consider a scratching post!
			</p>},
	image_url: 'tabby.jpg')
# . . .
Pet.create!(name: 'Bella',
	age: 3,
	breed: 'Husky',
	description:
		%{<p>
			Pretty puppy! Looking for a good home!
		  </p>},
	habits:
		%{<p>
			Likes to fetch<br>
			Digs holes when nervous<br>
			Loves children
			</p>},
	image_url: 'bella.jpg')
# . . .