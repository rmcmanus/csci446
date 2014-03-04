#!/usr/bin/ruby

# Ha ha. Get it? Book rack. That's clever right there.

require 'rack'
require_relative 'book_reader'

class SimpleApp
	def initialize()
    # can set up variables that will be needed later
    book_reader = BookListReader.new
    @list_of_books = book_reader.book_list
	end

  def call(env)
    # create request and response objects
    request = Rack::Request.new(env)
    response = Rack::Response.new

    File.open("header.html", "r") {|head| response.write(head.read)}
    case env["PATH_INFO"]
      when /.*?\.css/
        # serve up a css file
        # remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      when /\/list.*/
        sort_books(request, response)
        sort_books_list(request, response)
        render_books(request, response)
      else
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
    end # end case
    generate_footer(response)
    response.finish
  end

  def create_headers(req, response)
    response.write("  <tr>\n")
    response.write("    <th>Rank</td>\n")
    response.write("    <th>Title</td>\n")
    response.write("    <th>Author</td>\n")
    response.write("    <th>Language</td>\n")
    response.write("    <th>Year</td>\n")
    response.write("    <th>Copies</td>\n")
    response.write("  </tr>\n")
  end

  def render_books(req, response)
    response.write("<table>\n")
    create_headers(req, response)
    @list_of_books.each do |book|
      response.write("  <tr>\n")
      response.write("    <td>#{book.rank}</td>\n")
      response.write("    <td>#{book.title}</td>\n")
      response.write("    <td>#{book.author}</td>\n")
      response.write("    <td>#{book.language}</td>\n")
      response.write("    <td>#{book.year}</td>\n")
      response.write("    <td>#{book.copies}</td>\n")
      response.write("  </tr>\n")
    end
    response.write("</table>\n")
  end

  def sort_books_list(req, response)
    response.write("<form action=\"list\" method=\"get\">\n")

    response.write("  <select name=\"fields\">\n")
    response.write("    <option value=\"title\">Title</option>\n")
    response.write("    <option value=\"author\">Author</option>\n")
    response.write("    <option value=\"language\">Language</option>\n")
    response.write("    <option value=\"year\">Year</option>\n")
    response.write("  </select>\n")

    response.write("  <input type=\"submit\" value=\"Submit\"></input>\n")
    response.write("</form>\n")
  end

  def sort_books(req, response)
    input = req.GET["fields"]
    puts input
    if input == "title"
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

  def generate_footer(response)
    response.write("<footer>")
    response.write("  <p>Brought to you by: We LIEK Books!")
    response.write("</footer>")
  end
end


Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run SimpleApp.new, :Port => 8080
