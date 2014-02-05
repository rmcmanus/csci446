class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  	def current_adoption
  		Adoption.find(session[:adoption_id])
  	rescue ActiveRecord::RecordNotFound
  		adoption = Adoption.create
  		session[:adoption_id] = adoption.id
  		adoption
  	end
end
