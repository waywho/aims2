class BookingsController < ApplicationController
	before_action :load_client, :only => [:index, :show, :create]

  def index
  	@opportunity = @client.describe('Opportunity')
    @voice_types = @client.picklist_values('Contact', 'Voice_Type__c')
    @campaigns = @client.query("select Id, Name, Sub_Type__c from Campaign where IsActive = true and Type = 'Conference'")
    @summer_fees = @courseformats.where('title like ?', '%Summer School%').first.fees.order(:fee_type)
    @mini_fees = @courseformats.where('title like ?', '%Mini%').first.fees.order(:category)
    @audition_date = @courseformats.where('title like ?', '%Summer School%').first.audition_date
    @preferred_phone_values = @client.picklist_values('Contact', 'npe01__PreferredPhone__c')
    # @bookings = @client.query('select Amount, CloseDate, Name, Campaign_Name__c, Course__c from Opportunity')
    # @email = 'grant.access@logic.com'
    # @john = @client.search("FIND {walzerfan@yahoo.com} RETURNING Contact (Id, Name, AccountId, Web_uid__c)").map { |x| {id: x.Id, name: x.Name, account_id: x.AccountId, web_uid: x.Web_uid__c}}
    # uid = "12533"
    # johns = @client.query("select Id, AccountId, Name, Web_uid__c from Contact where Web_uid__c = '#{uid}'")
    # @john = johns.first
    # @contacts = @client.query('select Name from Contact')
    # @all = @client.describe
    # @opps = @client.query('select Id, Name from PricebookEntry')
    # @contact = @client.describe('Contact')
    # @sf_courses = @client.picklist_values('Opportunity', 'Course__c')
    # @session1_values = @client.picklist_values('Opportunity', 'Session_1__c')
    # @session2_values = @client.picklist_values('Opportunity', 'Session_2__c')
    # @session3_values = @client.picklist_values('Opportunity', 'Session_3__c')
    # @session4_values = @client.picklist_values('Opportunity', 'Session_4__c')
    # @audition = @client.picklist_values('Opportunity', 'Audition_requested__c')
    # @audition_for = @client.picklist_values('Opportunity', 'Auditioning_for__c')
    # @products = @client.query('select Id, Name from Product2')
  end

  def create
    booking_params = params[:booking].reject { |k, v| v.blank? }
    @campaign = find_campaign(booking_params[:campaign_id])
    product = select_product(@campaign)
    @product_description = "#{@campaign}: #{product.Description}"

    if params[:stripeToken] 

      @amount = (booking_params[:payment_amount].to_f * 100).to_i

      begin
        customer = Stripe::Customer.create(
            :email => booking_params[:email],
            :source  => params[:stripeToken]
          )

        charge = Stripe::Charge.create(
            :customer    => customer.id,
            :amount      => @amount,
            :description => @product_description,
            :currency    => 'gbp'
          )

      rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to bookings_path
      end

      account = SalesforceClient.new.find_create_update_contact(booking_params)
      @opp_uid = create_opp_uid(account.Name, @campaign)

      SalesforceClient.new.create_booking(booking_params, account, @opp_uid)

      opportunity = @client.find('Opportunity', @opp_uid, 'Web_uid__c')

      SalesforceClient.new.create_product(opportunity.Id, product.Id, product.UnitPrice)
      SalesforceClient.new.create_payment(@payment_after_service, opportunity.Id)


    elsif params[:bank_booking]
      account = SalesforceClient.new.find_create_update_contact(booking_params)
      @opp_uid = create_opp_uid(account.Name, @campaign)

      SalesforceClient.new.create_booking(booking_params, account, @opp_uid, params[:bank_booking])
      
      opportunity = @client.find('Opportunity', @opp_uid, 'Web_uid__c')

      SalesforceClient.new.create_product(opportunity.Id, product.Id, product.UnitPrice)
    end
    
    @service_fee = booking_params[:service_fee].to_f.number_to_currency(:unit => '£')
    @payment_after_service = (booking_params[:payment_amount].to_f - @service_fee).number_to_currency(:unit => '£')
    @total_paid = (@amount.to_f / 100).number_to_currency(:unit => '£')
    @payment_method = params[:options]
    @bank_details_page = Page.where(title: "Bank Transfer Details").first
    if @payment_method == 'bank'
      @amount_due = booking_params[:payment_amount].to_f.number_to_currency(:unit => '£')
    else
      @half_amount_remain = ((((product.UnitPrice).to_f - @payment_after_service.to_f))/2).number_to_currency(:unit => '£')
      @first_payment_date = @courseformats.where('title like ?', '%Summer School%').first.first_payment_date
      @second_payment_date = @courseformats.where('title like ?', '%Summer School%').first.second_payment_date
    end
    
    @name =  "#{booking_params[:first_name]} #{booking_params[:last_name]}"
    @salutation = booking_params[:salutation]
    @page = Page.where(title: whats_next_page_title(@campaign.Sub_Type__c)).first
    @email = booking_params[:email]
    
    send_notification_emails(@name, @email, @campaign, account.Web_uid__c, @opp_uid, @service_fee, 
      @payment_after_service, @total_paid, @payment_method, @amount_due, @half_amount_remain, @first_payment_date, @second_payment_date, @product_description)
    
    render :whats_next

    # redirect_to whats_next_path(type: @campaign.Sub_Type__c, salutation: booking_params[:salutation], name: account.Name, campaign: @campaign.Name, opp_uid: opp_uid)

  end

  def whats_next
    # @page = Page.where(title: whats_next_page_tite(params[:type])).first
    # @name = params[:name]
    # @opp_uid = params[:opp_uid]
    # @campaign_name = params[:campaign]
    # @salutation = params[:salutation]
  end

  def payment
    @email = params[:email] if params[:email]
    @confirmation = params[:confirmation_number] if params[:confirmation_number]
    @description = params[:product_description] if params[:product_description]
    @amount = params[:payment_amount] if params[:payment_amount]
    @payment_for = params[:payment_for] if params[:payment_for]
  end

  def charge
    @payment_amount = (payment_params[:payment_amount].to_f * 100).to_i
    @product_description = payment_params[:product_description]
    @email = payment_params[:email]
      begin
        customer = Stripe::Customer.create(
            :email => @email,
            :source  => params[:stripeToken]
          )

        charge = Stripe::Charge.create(
            :customer    => customer.id,
            :amount      => @payment_amount,
            :description => @product_description,
            :currency    => 'gbp'
          )

      rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to bookings_path
      end
    if payment_params[:payment_for] == "Course fee"
    end
    @service_fee = payment_params[:service_fee].to_f.number_to_currency(:unit => '£')
    @amount = payment_params[:amount].to_f.number_to_currency(:unit => '£')
    @stripe_id = charge.id
    @total_paid = payment_params[:payment_amount].to_f.number_to_currency(:unit => '£')

    NotificationMailer.confirm_payment(@email, charge.id, @product_description,  @amount, @service_fee, @total_paid).deliver_now

    render :confirm_payment
  end

  def confirm_payment
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

  def payment_params
    params.require(:stripe_payment).permit(:email, :confirmation_number, :product_description, :amount, :service_fee, :payment_amount, :payment_for)
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

  def send_notification_emails(name, email, campaign, web_uid, opp_uid, service_fee, payment_after_service, 
    payment, payment_method, amount_due, half_amount_remain = nil, first_payment_date = nil, second_payment_date = nil, product_description)
    NotificationMailer.booking_added(name, email, campaign, web_uid, opp_uid, payment_method).deliver_now
    NotificationMailer.confirm_booking(name, email, campaign, opp_uid, service_fee, payment_after_service, payment, payment_method, 
      amount_due, half_amount_remain, first_payment_date, second_payment_date, product_description).deliver_now
  end

  def select_product(campaign)
    if campaign.Sub_Type__c == 'Summer'
      @client.find('PricebookEntry', booking_params[:summer_product_code])
    elsif campaign.Sub_Type__c == 'Taster'
      @client.find('PricebookEntry', booking_params[:taster_product_code])
    end
  end

  def whats_next_page_title(campaign_type)
    "Whats Next #{campaign_type}"
  end

end
