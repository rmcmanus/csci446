class Animal < ActiveRecord::Base
	default_scope :order => 'name'
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero? 
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
		end
	end

	validates :name, :age, :breed, :image_url, :presence => true
	validates :age, :numericality => {:greater_than_or_equal_to => 1}

	validates :image_url, :format => {
		:with => %r{\.(gif|jpg|png)\z}i,
		:message => 'must be a URL for GIF, JPG or PNG image.'
	}
end
