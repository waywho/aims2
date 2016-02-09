class BookingsController < ApplicationController
	before_action :load_client, :only => [:index, :show]

  def index
  	# @bookings = @client.query('select Amount, CloseDate, Name, Campaign_Name__c, Course__c from Opportunity')
    # @email = 'grant.access@logic.com'
    # @john = @client.search("FIND {#{@email}} RETURNING Contact (Id)").map(&:Id)

    # @contacts = @client.query('select Name from Contact')
    # @all = @client.describe
  	@booking = @client.describe('Opportunity')
   #  @opp = @client.find('PricebookEntry', '01u24000000QmBaAAK')


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

    @campaigns = @client.query('select Id, Name from Campaign where IsActive = true')
    # @products = @client.query('select Id, Name from Product2')

  end

  def show
  end

  def create
    @client = Restforce.new

    booking_contact = @client.search("FIND {#{booking_params[:email]}} RETURNING Contact (Id)").map(&:Id)

    if booking_contact.nil?
      @client.create('Contact', 
          Web_uid__c: web_uid(booking_params[:first_name], booking_params[:last_name]),
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
          npe01__HomeEmail__c: booking_params[:email],
          LeadSource: 'Web' )

        @account = @client.find('Contact', @web_uid, 'Web_uid__c')

  else
    @client.update('Contact', 
      Id: "#{account}",
      Web_uid__c: web_uid(booking_params[:first_name], booking_params[:last_name]),
      Voice_Type__c: booking_params[:voice_type], 
      MailingStreet: booking_params[:street_address],
      MailingCity: booking_params[:city], 
      MailingState: booking_params[:county], 
      MailingPostalCode: booking_params[:post_code], 
      MailingCountry: booking_params[:country], 
      HomePhone: booking_params[:telephone], 
      MobilePhone: booking_params[:mobile],
      LeadSource: 'Web' )

    @account = @client.find('Contact', @web_uid, 'Web_uid__c')
  end

    @today = Time.now.to_formatted_s(:number)

    @client.create!('Opportunity',
      RecordTypeId: '01224000000DDUcAAO',
      Type: 'AIMS',
      Attendee_type__c: 'Student',
      CampaignId: '7017E0000000gTJQAY',
      AccountId: @account.AccountId,
      Name: opp_name(@account.Name, '7017E0000000gTJQAY'),
      StageName: 'Deposit Received',
      CloseDate: Time.now.to_datetime.strftime("%Y-%m-%d"),      
      Attendee_type__c: 'Student',
      Web_uid__c: opp_uid(@account.Name, '7017E0000000gTJQAY', @today),
      Car_Registration__c: booking_params[:car_reg],
      Course__c: booking_params[:course],
      Solo_classes__c: join_array(booking_params[:solo_classes]),
      Notes_for_class_selection__c: booking_params[:notes_for_class_selection],
      Session_1__c: booking_params[:session_1],
      Session_1_Options__c: join_array(booking_params[:session_1_options]),
      Session_2__c: booking_params[:session_2],
      Session_2_Options__c: join_array(booking_params[:session_2_options]),
      Session_3__c: booking_params[:session_3],
      Session_3_Options__c: join_array(booking_params[:session_3_options]),
      Session_4__c: booking_params[:session_4],
      Session_4_Options__c: join_array(booking_params[:session_4_options]),
      Audition_requested__c: booking_params[:audition],
      Auditioning_for__c: join_array(booking_params[:audition_for]),
      Audition_request_notes__c: booking_params[:audition_notes]
      )

    @opportunity = @client.find('Opportunity', @opp_uid, 'Web_uid__c')
    @product = @client.find('PricebookEntry', booking_params[:product_code])

    @client.create!('OpportunityLineItem',
      OpportunityId: @opportunity.Id,
      PricebookEntryId: booking_params[:product_code], 
      Quantity: "1.00",
      TotalPrice: @product.UnitPrice)

    redirect_to bookings_path
  end

  private

  def load_client
  	@client ||= Restforce.new(:oauth_token => Rails.cache.read('salesforceforce_oauth_token'))
  	Rails.cache.write('salesforceforce_oauth_token', @client.options[:oauth_token])
  end

  def booking_params
    params.require(:booking).permit(:salutation, :first_name, :last_name, :street_address, :campaign_id,
      :recordtype, :street_address, :city, :county, :country, :post_code, :email, :telephone, 
      :mobile, :date_of_birth, :car_reg, :voice_type, :course, {:solo_classes => []}, :notes_for_class_selection,
      :session_1, {:session_1_options => []}, :session_2, {:session_2_options => []}, :session_3, {:session_3_options => []},
      :session_4, {:session_4_options => []}, :audition, {:audition_for => []}, :audition_notes, :product_code, :payment_amount)
  end

  def web_uid(firstname, lastname)
    unique = ('a'..'z').to_a.shuffle[0,2].join
    @web_uid = "#{firstname.chr}#{lastname.chr}#{Time.now.to_formatted_s(:number)}#{unique}"
  end

  def opp_name(accountName, campaign_id)
    campaign = @client.find('Campaign', campaign_id)
    "#{campaign.Name}-#{accountName}"
  end

  def opp_uid(accountName, campaign_id, date)
    campaign = @client.find('Campaign', campaign_id)
    @opp_uid = "#{campaign.Name.split(' ').join}#{accountName.split(' ').join}#{date}"
  end

  def join_array(array)
    if array.present?
      array.join(";")
    else
      nil
    end
  end
end
