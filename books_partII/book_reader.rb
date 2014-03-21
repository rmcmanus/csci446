require 'sqlite3'
require_relative 'book.rb'

class BookListReader
	attr_accessor :book_list
	def initialize
		@book_list = Array.new
		@count = 1
		read
	end

	def read
		begin
			db = SQLite3::Database.new("books.sqlite3.db")
			db.results_as_hash = true
			result = db.execute "select * from books"

			result.each do |row|
				@book_list << Book.new(row['title'], row['author'], row['language'], row['published'], row['sold'], row['id'])
			end

		rescue SQLite3::Exception => e
    		puts "Exception occured"
    		puts e
		ensure
    		db.close if db
		end
	end
end