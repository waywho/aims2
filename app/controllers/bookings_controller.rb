class BookingsController < ApplicationController
	before_action :load_client, :only => [:index, :show, :create]

  def index
  	# @bookings = @client.query('select Amount, CloseDate, Name, Campaign_Name__c, Course__c from Opportunity')
    # @email = 'grant.access@logic.com'
    # @john = @client.search("FIND {walzerfan@yahoo.com} RETURNING Contact (Id, Name, AccountId, Web_uid__c)").map { |x| {id: x.Id, name: x.Name, account_id: x.AccountId, web_uid: x.Web_uid__c}}
    # uid = "12533"
    # johns = @client.query("select Id, AccountId, Name, Web_uid__c from Contact where Web_uid__c = '#{uid}'")
    # @john = johns.first
    # @contacts = @client.query('select Name from Contact')
    # @all = @client.describe
  	@opportunity = @client.describe('Opportunity')
    # @opps = @client.query('select Id, Name from PricebookEntry')
    # @contact = @client.describe('Contact')
    @preferred_phone_values = @client.picklist_values('Contact', 'npe01__PreferredPhone__c')

    @voice_types = @client.picklist_values('Contact', 'Voice_Type__c')

  	# @sf_courses = @client.picklist_values('Opportunity', 'Course__c')
    # @session1_values = @client.picklist_values('Opportunity', 'Session_1__c')
    # @session2_values = @client.picklist_values('Opportunity', 'Session_2__c')
    # @session3_values = @client.picklist_values('Opportunity', 'Session_3__c')
    # @session4_values = @client.picklist_values('Opportunity', 'Session_4__c')
    # @audition = @client.picklist_values('Opportunity', 'Audition_requested__c')
    # @audition_for = @client.picklist_values('Opportunity', 'Auditioning_for__c')

    @campaigns = @client.query("select Id, Name, Sub_Type__c from Campaign where IsActive = true and Type = 'Conference'")
    # @products = @client.query('select Id, Name from Product2')

    @summer_fees = @courseformats.where('title like ?', '%Summer School%').first.fees.order(:fee_type)

    @mini_fees = @courseformats.where('title like ?', '%Mini%').first.fees.order(:category)
  end

  def create

    booking_params = params[:booking].reject { |k, v| v.blank? }
    @campaign = find_campaign(booking_params[:campaign_id])
    product = select_product(@campaign)
    payment_after_service = (booking_params[:payment_amount].to_f - booking_params[:service_fee].to_f).to_s
    
    if params[:stripeToken] 

      @amount = (booking_params[:payment_amount].to_f * 100).to_i

      customer = Stripe::Customer.create(
          :email => booking_params[:email],
          :source  => params[:stripeToken]
        )

      charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => product.Description,
          :currency    => 'gbp'
        )

      account = SalesforceClient.new.find_create_update_contact(booking_params)

      @opp_uid = create_opp_uid(account.Name, @campaign)
      SalesforceClient.new.create_booking(booking_params, account, opp_uid)
      opportunity = @client.find('Opportunity', opp_uid, 'Web_uid__c')

      SalesforceClient.new.create_product(opportunity.Id, product.Id, product.UnitPrice)
      SalesforceClient.new.create_payment(payment_after_service, opportunity.Id)


    elsif params[:bank_booking]
      account = SalesforceClient.new.find_create_update_contact(booking_params)

      @opp_uid = create_opp_uid(account.Name, @campaign)
      SalesforceClient.new.create_booking(booking_params, account, opp_uid, params[:bank_booking])
      opportunity = @client.find('Opportunity', opp_uid, 'Web_uid__c')

      SalesforceClient.new.create_product(opportunity.Id, product.Id, product.UnitPrice)
    end

    @name =  "#{booking_params[:first_name]} #{booking_params[:last_name]}"
    @salutation = booking_params[:salutation]

    send_notification_emails(booking_params[:first_name], booking_params[:last_name], booking_params[:email], @campaign, account.Web_uid__c, @opp_uid)

    if params[:bank_booking]
      render :whats_next

    elsif booking_params[:stage] == 'Deposit'

    elsif booking_params[:stage] == 'Full Amount'

    end
    redirect_to whats_next_path(type: @campaign.Sub_Type__c, salutation: booking_params[:salutation], name: account.Name, campaign: @campaign.Name, opp_uid: opp_uid)

    rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to bookings_path
  end

  def whats_next
    @page = Page.where(title: whats_next_page_tite(params[:type])).first
    @name = params[:name]
    @opp_uid = params[:opp_uid]
    @campaign_name = params[:campaign]
    @salutation = params[:salutation]
  end

  private

  def load_client
  	@client ||= Restforce.new(:oauth_token => Rails.cache.read('salesforceforce_oauth_token'))
  	Rails.cache.write('salesforceforce_oauth_token', @client.options[:oauth_token])
  end

  def booking_params
    params.require(:booking).permit(:salutation, :first_name, :last_name, :street_address, :campaign_id,
      :recordtype, :street_address, :city, :county, :country, :post_code, :email, :preferred_contact,
      :contact_number, :date_of_birth, :car_reg, :voice_type, :course_stream_summer, :course_stream_mini,  
      {:days => []}, {:solo_classes => []}, :notes_for_class_selection,
      :session_1, {:session_1_options => []}, :session_2, {:session_2_options => []}, :session_3, {:session_3_options => []},
      :session_4, {:session_4_options => []}, :stage, :agreement, :audition, {:audition_for => []}, :audition_notes, 
      :summer_product_code, :taster_product_code, :service_fee, :payment_amount)
  end

  # def create_web_uid(firstname, lastname)
  #   unique = ('a'..'z').to_a.shuffle[0,2].join
  #   "#{firstname.chr}#{lastname.chr}#{Time.now.to_formatted_s(:number)}#{unique}"
  # end

  def create_opp_uid(accountName, campaign)
    timecode = Time.now.to_formatted_s(:number)
    "#{campaign.Name.split(' ').join}#{accountName.split(' ').join}#{timecode}"
  end

  def find_campaign(campaign_id)
    @client.find('Campaign', campaign_id)
  end

  def send_notification_emails(first_name, last_name, email, campaign, web_uid, opp_uid)
    NotificationMailer.booking_added(first_name, last_name, email, campaign, web_uid, opp_uid).deliver_now
    NotificationMailer.confirm_booking(first_name, last_name, email, campaign, opp_uid).deliver_now
  end

  def select_product(campaign)
    if @campaign.Sub_Type__c == 'Summer'
      @client.find('PricebookEntry', booking_params[:summer_product_code])
    elsif @campaign.Sub_Type__c == 'Taster'
      @client.find('PricebookEntry', booking_params[:taster_product_code])
    end
  end

  def redirect_with_stage(stage, bank_params = nil)
    if bank_params.present?
      "Prospective"
    else
      if stage == "Deposit"
        "Deposit Received"
      elsif stage == "Full Amount"
        "Fully Paid"
      end
    end
  end

end
