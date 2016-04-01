class NotificationMailer < ApplicationMailer
	default from: "no-reply@aims.uk.com"

	def booking_added(name, booking_email, campaign, web_uid, opp_uid)
		@name = name
		@email = booking_email
		@campaign = campaign.Name
		@web_uid = web_uid
		@opp_uid = opp_uid
		mail(to: "walzerfan@yahoo.com",
			subject: "A new booking for #{@campaign} has been submitted")
	end

	def confirm_booking(name, booking_email, campaign, opp_uid, service_fee, payment_after_service, payment, payment_method, amount_due, half_amount_remain)
		@name = @name
		@email = booking_email
		@campaign = campaign.Name
		@opp_uid = opp_uid
		@page = Page.where(title: whats_next_page_title(campaign.Sub_Type__c)).first
		 @bank_details_page = Page.where(title: "Bank Transfer Details").first
		mail(to: @email,
			subject: "Booking Submitted: #{@campaign}")
	end

	private

	def whats_next_page_title(campaign_type)
		"Whats Next #{campaign_type}"
	end
end
