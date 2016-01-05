class Menu < ActiveRecord::Base
	has_ancestry
	belongs_to :navigation, polymorphic: true

	TYPES = ['main', 'secondary', 'footer']
end
