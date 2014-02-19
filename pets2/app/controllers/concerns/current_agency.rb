module CurrentAgency
	extend ActiveSupport::Concern

	private

		def set_agency
			@agency = Agency.find(session[:agency_id])
		rescue ActiveRecord::RecordNotFound
			@agency = Agency.create
			session[:agency_id] = @agency.id
		end
end