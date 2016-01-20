class BookingsController < ApplicationController
  def index
  	@bookings = Restforce.new.query_all('Opportunity')
  end

  def show
  end
end
