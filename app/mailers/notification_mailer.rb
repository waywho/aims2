class NotificationMailer < ApplicationMailer
	default from: "no-reply@aims.uk.com"

	def booking_added(first_name, last_name, booking_email, campaign, web_uid, opp_uid)
		@first_name = first_name
		@last_name = last_name
		@email = booking_email
		@campaign = campaign.Name
		@web_uid = web_uid
		@opp_uid = opp_uid
		mail(to: "walzerfan@yahoo.com",
			subject: "A new booking for #{@campaign} has been submitted")
	end

	def confirm_booking(first_name, last_name, booking_email, campaign, opp_uid)
		@first_name = first_name
		@last_name = last_name
		@email = booking_email
		@campaign = campaign.Name
		@opp_uid = opp_uid
		@page = Page.where(title: whats_next_page_title(campaign.Sub_Type__c)).take
		mail(to: @email,
			subject: "Booking Submitted: #{@campaign}")
	end

	private

	def whats_next_page_title(campaign_type)
		"Whats Next #{campaign_type}"
	end
end
