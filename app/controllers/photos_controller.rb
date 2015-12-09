class PhotosController < ApplicationController
	# before_action :current_imageable

	def index
		@photos = @imageable.photos
	end

	private

	# def current_imageable
	# 	resource, id = request.path.split('/')[1, 2]
	# 	@imageable = resource.singularize.classify.constantize.friendly.find(id)
	# end

end
