class BookingsController < ApplicationController
	before_action :load_client

  def index
  	# @bookings = @client.query('select Amount, CloseDate, Name, Campaign_Name__c, Course__c from Opportunity')
  	# @accounts = @client.query('select Name from Account')
  	@booking = @client.describe('Opportunity')

  	@sf_courses = @client.picklist_values('Opportunity', 'Course__c')
    @solo_classes = @client.picklist_values('Opportunity', 'Solo_classes__c')
    
    @session1 = @client.picklist_values('Opportunity', 'Session_1__c')
    @session1_options = @client.picklist_values('Opportunity', 'Session_1_Options__c')
    @session2 = @client.picklist_values('Opportunity', 'Session_2__c')
    @session2_options = @client.picklist_values('Opportunity', 'Session_2_Options__c')
    @session3 = @client.picklist_values('Opportunity', 'Session_3__c')
    @session3_options = @client.picklist_values('Opportunity', 'Session_3_Options__c')
    @session4 = @client.picklist_values('Opportunity', 'Session_4__c')
    @session4_options = @client.picklist_values('Opportunity', 'Session_4_Options__c')
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
