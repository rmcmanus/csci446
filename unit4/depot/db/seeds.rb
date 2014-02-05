# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Animal.delete_all
# . . .
Animal.create(:name => "Maggie",
							:breed => "Dog",
							:age => 10,
							:image_url => "/images/yellow_lab.jpg")
# . . .
Animal.create(:name => "Laurel",
							:breed => "Cat",
							:age => 6,
							:image_url => "/images/cat.jpg")
# . . .
Animal.create(:name => "Ferry",
							:breed => "Ferret",
							:age => 2,
							:image_url => "/images/ferret.jpg")
# . . .