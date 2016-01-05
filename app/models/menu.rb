class Menu < ActiveRecord::Base
	has_ancestry
	belongs_to :navigation, polymorphic: true
	scope :main, -> {where(menu_type: "main")}
	scope :secondary, -> {where(menu_type: "secondary")}
	scope :footer, -> {where(menu_type: "footer")}

	TYPES = ['main', 'secondary', 'footer']
end
