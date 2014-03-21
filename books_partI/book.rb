class Book
	attr_accessor :title, :author, :language, :year, :copies, :rank
	def initialize(title, author, language, year, copies, rank)
		@title = title
		@author = author
		@language = language
		@year = year
		@copies = copies
		@rank = rank
	end
end