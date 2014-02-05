class AgencyController < ApplicationController
  def index
  	@animals = Animal.all
  end

  # Create the sort functions here, call them in index.html.erb as function_path()
  def sort_name_path(name)
  	@animals = Animal.order(name)
  end

  def sort_age_path(age)
  	@animals = Animal.order(age)
  end
end
