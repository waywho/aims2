class BookingsController < ApplicationController
	before_action :load_client, :only => [:index, :show]

  def index
  	# @bookings = @client.query('select Amount, CloseDate, Name, Campaign_Name__c, Course__c from Opportunity')
  	@contacts = @client.query('select Name from Contact')
    # @all = @client.describe
  	@booking = @client.describe('Opportunity')

    @contact = @client.describe('Contact')

    @booking_courseformat = Courseformat.where(title: 'Summer School 2016').includes(:fees)

    @voice_types = @client.picklist_values('Contact', 'Voice_Type__c')
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
    Restforce.new.create('Contact', 
      Salutation: booking_params[:salutation], 
      LastName: booking_params[:last_name], 
      FirstName: booking_params[:first_name], 
      Voice_Type__c: booking_params[:voice_type], 
      MailingStreet: booking_params[:street_address],
      MailingCity: booking_params[:city], 
      MailingState: booking_params[:county], 
      MailingPostalCode: booking_params[:post_code], 
      MailingCountry: booking_params[:country], 
      HomePhone: booking_params[:telephone], 
      MobilePhone: booking_params[:mobile],
      Birthdate: booking_params[:date_of_birth].to_datetime.strftime("%Y-%m-%d"), 
      npe01__HomeEmail__c: booking_params[:email] )

    redirect_to bookings_path
  end

  private

  def load_client
  	@client ||= Restforce.new(:oauth_token => Rails.cache.read('salesforceforce_oauth_token'))
  	Rails.cache.write('salesforceforce_oauth_token', @client.options[:oauth_token])
  end

  def booking_params
    params.require(:booking).permit(:salutation, :first_name, :last_name, :street_address, 
      :recordtype, :street_address, :city, :county, :country, :post_code, :email, :telephone, 
      :mobile, :date_of_birth, :car_reg, :voice_type, :solo_classes, :notes_for_class_selection,
      :session_1, :session_1_options, :session2, :session_2_options, :session3, :session_3_options,
      :session4, :session_4_options, :audition, :audition_for, :product_code, :payment_amount)
  end

  def full_name
    "#{booking_params[:first_name]} #{booking_params[:last_name]}"
  end
end
