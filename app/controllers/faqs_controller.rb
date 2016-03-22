class FaqsController < ApplicationController
	def index
  		@faqs = Faq.published_now.order(published_at: :desc)
  	end

end
