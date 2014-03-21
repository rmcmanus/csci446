#!/usr/bin/ruby

# Ha ha. Get it? Book rack. That's clever right there.
require 'rack'
require 'erb'
require 'sqlite3'
require_relative 'book_reader'

class SimpleApp
  attr_accessor :list_of_books

	def initialize()
    # can set up variables that will be needed later
    book_reader = BookListReader.new
    @list_of_books = book_reader.book_list
	end

  def call(env)
    # create request and response objects
    request = Rack::Request.new(env)
    response = Rack::Response.new

    response.write(ERB.new(File.read("header.html.erb")).result(binding))
    case env["PATH_INFO"]
      when /.*?\.css/
        # serve up a css file
        # remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      when /\/list.*/
        sort_books(request, response)
        render_books(request, response)
      when /\/form.*/
        sort_books_list(request, response)
      else
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
    end # end case
    generate_footer(response)
    response.finish
  end

  def render_books(req, response)
    response.write(ERB.new(File.read("list.html.erb")).result(binding))
  end

  def sort_books_list(req, response)
    response.write(ERB.new(File.read("form.html.erb")).result(binding))
  end

  def generate_footer(response)
    response.write(ERB.new(File.read("footer.html.erb")).result(binding))
  end

  def sort_books(req, response)
    input = req.GET["fields"]
    if input == "id"
      @list_of_books = @list_of_books.sort_by(&:rank)
    elsif input == "title"
      @list_of_books = @list_of_books.sort_by(&:title)
    elsif input == "author"
      @list_of_books = @list_of_books.sort_by(&:author)
    elsif input == "language"
      @list_of_books = @list_of_books.sort_by(&:language)
    elsif input == "year"
      @list_of_books = @list_of_books.sort_by(&:year)
    else
      @list_of_books = @list_of_books.sort_by(&:rank)
    end
  end
end

Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}
Rack::Handler::WEBrick.run SimpleApp.new, :Port => 8080
