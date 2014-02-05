require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
	fixtures :animals

	def new_animal(image_url)
		Animal.new(:name => "MadDog",
							 :breed => "Ferret",
							 :age => 5,
							 :image_url => image_url)
	end

  test "animal attributes must not be empty" do
  	animal = Animal.new

	  assert animal.invalid?
	  assert animal.errors[:name].any?
	  assert animal.errors[:age].any?
	  assert animal.errors[:breed].any?
	  assert animal.errors[:image_url].any?
	end

	test "animal age must be positive" do
		animal = Animal.new(:name => "MadDog",
												:breed => "Ferret",
												:image_url => "animal.jpg")

		animal.age = 0
		assert animal.invalid?
		assert_equal "must be greater than or equal to 1", animal.errors[:age].join('; ')

		animal.age = 1
		assert animal.valid?

	end

	test "image url" do
		ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
		bad = %w{ fred.doc fred.gif/more fred.gif.more }

		ok.each do |name|
			assert new_animal(name).valid?, "#{name} shouldn't be invalid"
		end

		bad.each do |name|
			assert new_animal(name).invalid?, "#{name} shouldn't be valid"
		end
	end
end
