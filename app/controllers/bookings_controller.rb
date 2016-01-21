class BookingsController < ApplicationController
  def index
  	@client = Restforce.new
  	@bookings = @client.query('select Name from Opportunity')
  end

  def show
  end
end
