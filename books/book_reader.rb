require_relative 'book.rb'

class BookListReader
	attr_accessor :book_list
	def initialize
		@book_list = Array.new
		@count = 1
		read
	end

	def read
		File.open("books.txt", "r") do |line|
			while book = line.gets
				new_book = book.strip.split(/,\W/)
				@book_list << Book.new(new_book[0], new_book[1], new_book[2], new_book[3], new_book[4], @count)
				@count += 1
			end
		end
	end
end

# book = BookListReader.new
# book.book_list.each do |test|
# 	puts "#{test.title}"
# end