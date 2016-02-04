class BookingsController < ApplicationController
	before_action :load_client

  def index
  	# @bookings = @client.query('select Amount, CloseDate, Name, Campaign_Name__c, Course__c from Opportunity')
  	# @accounts = @client.query('select Name from Account')
    @all = @client.describe
  	@booking = @client.describe('Opportunity')
    @fees = Fee.where(courseformat: "Summer School 2016")


  	@sf_courses = @client.picklist_values('Opportunity', 'Course__c')
    @solo_classes = @client.picklist_values('Opportunity', 'Solo_classes__c')
    
    @session1_values = @client.picklist_values('Opportunity', 'Session_1__c')

    @session2_values = @client.picklist_values('Opportunity', 'Session_2__c')

    @session3_values = @client.picklist_values('Opportunity', 'Session_3__c')

    @session4_values = @client.picklist_values('Opportunity', 'Session_4__c')

    @audition = @client.picklist_values('Opportunity', 'Audition_requested__c')

    @audition_for = @client.picklist_values('Opportunity', 'Auditioning_for__c')

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
