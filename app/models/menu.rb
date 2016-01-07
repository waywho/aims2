class Menu < ActiveRecord::Base
	has_ancestry
	include RankedModel
	ranks :row_order, :with_same => :menu_type

	belongs_to :navigation, polymorphic: true
	scope :main, -> {where(menu_type: "main")}
	scope :secondary, -> {where(menu_type: "secondary")}
	scope :footer, -> {where(menu_type: "footer")}
	scope :unassigned, -> {where(menu_type: nil || "")}

	TYPES = ['main', 'secondary', 'footer']
end
