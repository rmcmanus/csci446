#!/usr/bin/ruby

require 'sinatra'
require 'data_mapper'
require_relative 'book'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/books.sqlite3.db")

get '/list' do
  @books = Book.all
  erb :list
end

post '/list' do
  @books = Book.all
  erb :list
end

get '/form' do
  erb :form
end