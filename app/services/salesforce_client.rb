class SalesforceClient

	def create_salesforce_contact(params, web_uid)
		Restforce.new.create!('Contact', 
          Web_uid__c: web_uid,
          Salutation: params[:salutation], 
          LastName: params[:last_name], 
          FirstName: params[:first_name], 
          Voice_Type__c: params[:voice_type], 
          MailingStreet: params[:street_address],
          MailingCity: params[:city], 
          MailingState: params[:county], 
          MailingPostalCode: params[:post_code], 
          MailingCountry: params[:country], 
          HomePhone: params[:telephone], 
          MobilePhone: params[:mobile],
          Birthdate: date_string(params[:date_of_birth]), 
          npe01__HomeEmail__c: params[:email],
          LeadSource: 'Web' )

	end

	def update_salesforce_contact(params, contact_id)
		Restforce.new.update!('Contact', 
	        Id: contact_id,
	        Voice_Type__c: params[:voice_type], 
	        MailingStreet: params[:street_address],
	        MailingCity: params[:city], 
	        MailingState: params[:county], 
	        MailingPostalCode: params[:post_code], 
	        MailingCountry: params[:country], 
	        HomePhone: params[:telephone], 
	        MobilePhone: params[:mobile],
	        LeadSource: 'Web' )
	end

	def create_booking(params, account, opp_uid)
		Restforce.new.create!('Opportunity',
		    RecordTypeId: '01224000000DDUcAAO',
		    Type: 'AIMS',
		    Attendee_type__c: 'Student',
		    CampaignId: params[:campaign_id],
		    AccountId: account.AccountId,
		    Name: opp_name(account.Name, params[:campaign_id]),
		    StageName: 'Deposit Received',
		    CloseDate: Time.now.to_datetime.strftime("%Y-%m-%d"),
		    Web_uid__c: opp_uid,
		    Car_Registration__c: params[:car_reg],
		    Course__c: params[:course],
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
		    Audition_request_notes__c: params[:audition_notes]
		      )
	end

	def create_product(opp_id, product_id, price)
		Restforce.new.create!('OpportunityLineItem',
		    OpportunityId: opp_id,
		    PricebookEntryId: product_id, 
		    Quantity: "1.00",
		    TotalPrice: price)
	end

	def create_payment(payment_amount, opp_id)
		Restforce.new.create!('npe01__OppPayment__c', 
			npe01__Paid__c: true,
			npe01__Opportunity__c: opp_id,
			npe01__Payment_Amount__c: payment_amount,
			npe01__Payment_Method__c: 'Cash')
	end

	private
	def date_string(date)
		if date.present?
			date.to_datetime.strftime("%Y-%m-%d")
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