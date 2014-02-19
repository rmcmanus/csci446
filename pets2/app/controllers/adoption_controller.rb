class AdoptionController < ApplicationController
	include CurrentAgency
	before_action :set_agency
  def index
  	@pets = Pet.order(:name)
  end

  def order_alphabetical
  	@pets = Pet.order(:name)
  end

  def order_age
  	@pets = Pet.order(:age)
  end
end
