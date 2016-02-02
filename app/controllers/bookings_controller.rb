class BookingsController < ApplicationController
	before_action :load_client

  def index
  	# @bookings = @client.query('select Account, Name from Opportunity')
  	@bookings = @client.describe_layouts('Opportunity')

  	# @choral = @client.picklist_values('Opportunity', 'Choral_Classes_c')
  end

  def show
  end

  def create
  end

  private

  def load_client
  	@client ||= Restforce.new(:oauth_token => Rails.cache.read('salesforceforce_oauth_token'))
  	Rails.cache.write('salesforceforce_oauth_token', @client.options[:oauth_token])
  end

end
