class BookingsController < ApplicationController
	before_action :load_client

  def index
  	@bookings = @client.query('select Amount, CloseDate, Name, Campaign_Name__c, Course__c from Opportunity')
  	@accounts = @client.query('select Name from Account')
  	# @bookings = @client.describe('Opportunity')

  	@choral_classes = @client.picklist_values('Opportunity', 'Choral_Classes__c')
  	@sf_courses = @client.picklist_values('Opportunity', 'Course__c')
  	@ensemble_classes = @client.picklist_values('Opportunity', 'Ensemble_Classes__c')

  end

  def show
  end

  def create
  	# @client.create('Account')
  end

  private

  def load_client
  	@client ||= Restforce.new(:oauth_token => Rails.cache.read('salesforceforce_oauth_token'))
  	Rails.cache.write('salesforceforce_oauth_token', @client.options[:oauth_token])
  end

  def course_params
    params.require(:booking).permit(:name, :recordtype, :phone, :billingaddress, :email, :firstName, :lastName)
  end
end
