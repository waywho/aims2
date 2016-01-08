class Recordfy < ActiveRecord::Base
	belongs_to :entriable, polymorphic: true
	belongs_to :page

end
