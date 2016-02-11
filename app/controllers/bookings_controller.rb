class BookingsController < ApplicationController
	before_action :load_client, :only => [:index, :show]

  def index
  	# @bookings = @client.query('select Amount, CloseDate, Name, Campaign_Name__c, Course__c from Opportunity')
    # @email = 'grant.access@logic.com'
    # @john = @client.search("FIND {#{@email}} RETURNING Contact (Id)").map(&:Id)

    # @contacts = @client.query('select Name from Contact')
    # @all = @client.describe
  	@booking = @client.describe('Opportunity')
    # @opps = @client.query('select Id, Name from PricebookEntry')

    @contact = @client.describe('Contact')

    @voice_types = @client.picklist_values('Contact', 'Voice_Type__c')

  	@sf_courses = @client.picklist_values('Opportunity', 'Course__c')
    
    @solo_classes = @client.picklist_values('Opportunity', 'Solo_classes__c')
    
    @session1_values = @client.picklist_values('Opportunity', 'Session_1__c')

    @session2_values = @client.picklist_values('Opportunity', 'Session_2__c')

    @session3_values = @client.picklist_values('Opportunity', 'Session_3__c')

    @session4_values = @client.picklist_values('Opportunity', 'Session_4__c')

    @audition = @client.picklist_values('Opportunity', 'Audition_requested__c')

    @audition_for = @client.picklist_values('Opportunity', 'Auditioning_for__c')

    @campaigns = @client.query("select Id, Name, Sub_Type__c from Campaign where IsActive = true and Type = 'Conference'")
    # @products = @client.query('select Id, Name from Product2')

    @summer_fees = @courseformats.where('title like ?', '%Summer School%').first.fees.order(:fee_type)

    @mini_fees = @courseformats.where('title like ?', '%Mini%').first.fees.order(:category)


  end

  def summer_booking
  end

  def mini_booking
  end

  def create
    @client = Restforce.new

    booking_contact = @client.search("FIND {#{booking_params[:email]}} RETURNING Contact (Id)").map(&:Id)
    
    if booking_contact.empty?
      web_uid = web_uid(booking_params[:first_name], booking_params[:last_name])
      SalesforceClient.new.create_salesforce_contact(booking_params, web_uid)
      @account = @client.find('Contact', web_uid, 'Web_uid__c')
    else
      SalesforceClient.new.update_salesforce_contact(booking_params, booking_contact.first)
      @account = @client.find('Contact', booking_contact.first)
    end

    opp_uid = opp_uid(@account.Name, '7017E0000000gTJQAY')

    SalesforceClient.new.create_booking(booking_params, @account, opp_uid)

    opportunity = @client.find('Opportunity', opp_uid, 'Web_uid__c')
    product = @client.find('PricebookEntry', booking_params[:product_code])

    SalesforceClient.new.create_product(booking_params, opportunity.Id, product.UnitPrice)

    SalesforceClient.new.create_payment(booking_params[:payment_amount], opportunity.Id)

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
      :mobile, :date_of_birth, :car_reg, :voice_type, :course,  {:days => []}, {:solo_classes => []}, :notes_for_class_selection,
      :session_1, {:session_1_options => []}, :session_2, {:session_2_options => []}, :session_3, {:session_3_options => []},
      :session_4, {:session_4_options => []}, :audition, {:audition_for => []}, :audition_notes, :product_code, :payment_amount)
  end

  def web_uid(firstname, lastname)
    unique = ('a'..'z').to_a.shuffle[0,2].join
    "#{firstname.chr}#{lastname.chr}#{Time.now.to_formatted_s(:number)}#{unique}"
  end

  def opp_uid(accountName, campaign_id)
    campaign = @client.find('Campaign', campaign_id)
    timecode = Time.now.to_formatted_s(:number)
    "#{campaign.Name.split(' ').join}#{accountName.split(' ').join}#{timecode}"
  end


end
