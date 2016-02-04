class BookingsController < ApplicationController
	before_action :load_client

  def index
  	# @bookings = @client.query('select Amount, CloseDate, Name, Campaign_Name__c, Course__c from Opportunity')
  	# @accounts = @client.query('select Name from Account')
    # @all = @client.describe
  	@booking = @client.describe('Opportunity')

    @booking_courseformat = Courseformat.where(title: 'Summer School 2016').includes(:fees)

    @voice_types = @client.picklist_values('Contact', 'Voice_type__c')
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
  	@client.create('Contact', Name: :full_name, Voice_type__c: course_params[:voice_type] )
  end

  private

  def load_client
  	@client ||= Restforce.new(:oauth_token => Rails.cache.read('salesforceforce_oauth_token'))
  	Rails.cache.write('salesforceforce_oauth_token', @client.options[:oauth_token])
  end

  def course_params
    params.require(:booking).permit(:salutation, :first_name, :last_name, :street_address, 
      :recordtype, :street_address, :city, :county, :country, :post_code, :email, :telephone, 
      :mobile, :date_of_birth, :car_reg, :voice_type, :solo_classes, :notes_for_class_selection,
      :session_1, :session_1_options, :session2, :session_2_options, :session3, :session_3_options,
      :session4, :session_4_options, :audition, :audition_for, :product_code, :payment_amount)
  end

  def full_name
    "#{course_params[:first_name]} #{course_params[:last_name]}
  end
end
