class Pet < ActiveRecord::Base
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :name, :breed, :description, :habits, :image_url, presence: true
	validates :age, numericality: {greater_than_or_equal_to: 0}
	validates :name, uniqueness: true
	validates :image_url, allow_blank: true, format: {
    	with:    %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.' 
	}

	def self.latest
		Pet.order(:updated_at).last
	end

	private

		def ensure_not_referenced_by_any_line_item
			if line_items.empty?
				return true
			else
				errors.add(:base, 'Line Items present')
				return false
			end
		end
end
