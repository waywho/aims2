class BookingsController < ApplicationController
	include Databasedotcom::Rails::Controller

	def index
		@opportunities = Opportunity.all
  	end

  	def show
  	end
end
