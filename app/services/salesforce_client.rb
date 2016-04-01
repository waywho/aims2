class SalesforceClient

	# def initialize(params, client)
	# 	@params = params
	# 	load_client
	# end

	def find_create_update_contact(params)
		load_client
		contact = return_contact(params[:email])

		if contact.empty?
			uid = create_web_uid(params[:first_name], params[:last_name])
			create_salesforce_contact(params, uid)
		else
			uid = contact[:web_uid] || create_web_uid(params[:first_name], params[:last_name])
			update_salesforce_contact(params, contact[:id], uid)
		end
		accounts = @client.query("select Id, AccountId, Name, Web_uid__c from Contact where Web_uid__c = '#{uid}'")
		account = accounts.first
	end

	def create_salesforce_contact(params, uid)
		load_client
		@client.create!('Contact', 
          Web_uid__c: uid,
          Salutation: params[:salutation], 
          LastName: params[:last_name], 
          FirstName: params[:first_name], 
          Voice_Type__c: params[:voice_type], 
          MailingStreet: params[:street_address],
          MailingCity: params[:city], 
          MailingState: params[:county], 
          MailingPostalCode: params[:post_code], 
          MailingCountry: params[:country],
          Birthdate: date_string(params[:date_of_birth]), 
          npe01__HomeEmail__c: params[:email],
          LeadSource: 'Web' )

		update_phone(params[:preferred_contact], params[:contact_number], uid)
	end

	def update_salesforce_contact(params, contact_id, uid)
		load_client
		@client.update!('Contact', 
	        Id: contact_id,
	        Web_uid__c: uid,
	        Voice_Type__c: params[:voice_type], 
	        MailingStreet: params[:street_address],
	        MailingCity: params[:city], 
	        MailingState: params[:county], 
	        MailingPostalCode: params[:post_code], 
	        MailingCountry: params[:country],
	        LeadSource: 'Web' )

		update_phone(params[:preferred_contact], params[:contact_number], uid)
	end

	def create_booking(params, account, opp_uid, bank_params = nil)
		load_client
		course_selection = params[:course_stream_summer] || params[:course_stream_mini]
		@client.create!('Opportunity',
		    RecordTypeId: '01224000000DDUcAAO',
		    Type: 'AIMS',
		    Attendee_type__c: 'Student',
		    CampaignId: params[:campaign_id],
		    AccountId: account.AccountId,
		    Name: opp_name(account.Name, params[:campaign_id]),
		    StageName: booking_stage(params[:stage], bank_params),
		    CloseDate: Time.now.to_datetime.strftime("%Y-%m-%d"),
		    Web_uid__c: opp_uid,
		    Car_Registration__c: params[:car_reg],
		    Course__c: course_selection,
		    Solo_classes__c: join_array(params[:solo_classes]),
		    Notes_for_class_selection__c: params[:notes_for_class_selection],
		    Session_1__c: params[:session_1],
		    Session_1_Options__c: join_array(params[:session_1_options]),
		    Session_2__c: params[:session_2],
		    Session_2_Options__c: join_array(params[:session_2_options]),
		    Session_3__c: params[:session_3],
		    Session_3_Options__c: join_array(params[:session_3_options]),
		    Session_4__c: params[:session_4],
		    Session_4_Options__c: join_array(params[:session_4_options]),
		    Audition_requested__c: params[:audition],
		    Auditioning_for__c: join_array(params[:audition_for]),
		    Audition_request_notes__c: params[:audition_notes] )
	end

	def create_product(opp_id, product_id, price)
		load_client
		@client.create!('OpportunityLineItem',
		    OpportunityId: opp_id,
		    PricebookEntryId: product_id, 
		    Quantity: "1.00",
		    TotalPrice: price)
	end

	def create_payment(payment_amount, opp_id)
		load_client
		@client.create!('npe01__OppPayment__c', 
			npe01__Paid__c: true,
			npe01__Opportunity__c: opp_id,
			npe01__Payment_Amount__c: payment_amount,
			npe01__Payment_Method__c: 'Stripe')
	end

	def update_phone(preferred_contact, phone, uid)
		load_client
		if preferred_contact == "Home"
			@client.upsert!('Contact', 'Web_uid__c',
				Web_uid__c: uid,
				npe01__PreferredPhone__c: preferred_contact,
	        	HomePhone: phone)
		elsif preferred_contact == 'Mobile'
			@client.upsert!('Contact', 'Web_uid__c',
				Web_uid__c: uid,
				npe01__PreferredPhone__c: preferred_contact,
				MobilePhone: phone)
		else @client.upsert!('Contact', 'Web_uid__c',
				Web_uid__c: uid,
				npe01__PreferredPhone__c: preferred_contact,
				npe01__WorkPhone__c: phone)
		end
	end

	private

	def load_client
		@client ||= Restforce.new(:oauth_token => Rails.cache.read('salesforceforce_oauth_token'))
  			Rails.cache.write('salesforceforce_oauth_token', @client.options[:oauth_token])
	end

	def return_contact(email)
 		contacts = @client.search("FIND {#{email}} RETURNING Contact (Id, Web_uid__c)").map { |x| {id: x.Id, web_uid: x.Web_uid__c}}
		contacts.first
	end

	def create_web_uid(firstname, lastname)
    	unique = ('a'..'z').to_a.shuffle[0,2].join
    	"#{firstname.chr}#{lastname.chr}#{Time.now.to_formatted_s(:number)}#{unique}"
  	end

	def date_string(date)
		if date.present?
			date.to_datetime.strftime("%Y-%m-%d")
		end
	end

	def booking_stage(stage, bank_params = nil)
		if bank_params.present?
			"Prospective"
		elsif stage == "Deposit"
			"Deposit Received"
		elsif stage == "Full Amount"
			"Fully Paid"
		end
	end

	def opp_name(accountName, campaign_id)
	    campaign = Restforce.new.find('Campaign', campaign_id)
	    "#{campaign.Name}-#{accountName}"
  	end

  	 def join_array(array)
	    if array.present?
	      array.join(";")
	    else
	      nil
	    end
  	end

end