require 'test_helper'

class PetTest < ActiveSupport::TestCase
  test "pet attributes must not be empty" do
  	pet = Pet.new
  	assert pet.invalid?
  	assert pet.errors[:name].any?
  	assert pet.errors[:age].any?
  	assert pet.errors[:breed].any?
  	assert pet.errors[:description].any?
  	assert pet.errors[:habits].any?
  	assert pet.errors[:image_url].any?
  end

  test "pet age must be positive" do
  	pet = Pet.new(name: 'Doggie',
  								breed: 'Dog',
  								description: 'This is dog',
  								habits: 'Tends to dog',
  								image_url: 'dog.jpg')
  	
  	pet.age = -2
  	assert pet.invalid?
  	assert_equal ["must be greater than or equal to 0"], pet.errors[:age]

  	pet.age = -1
  	assert pet.invalid?
  	assert_equal ["must be greater than or equal to 0"], pet.errors[:age]

  	pet.age = 1
  	assert pet.valid?
  end

  def new_pet(image_url)
  	Pet.new(name: 				'Doggie',
  					age: 					4,
  					breed: 				'Dog',
  					description: 	'This is dog',
  					habits: 			'Tends to dog',
  					image_url: 		image_url)
  end

  test "image url" do
  	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
  	bad = %w{ fred.doc fred.gif/more fred.gif.more }

  	ok.each do |name|
  		assert new_pet(name).valid?, "#{name} should be valid"
  	end

  	bad.each do |name|
  		assert new_pet(name).invalid?, "#{name} should not be valid"
  	end
  end
end
