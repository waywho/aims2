class Casein::DraftsController < ApplicationController


	def update
		@draft = Draftsman::Draft.find(params[:id])
		@draft.publish!
		flash[:success] = 'The draft was published successfully.'
      	redirect_to admin_drafts_path
	end
end
