class NotificationMailer < ApplicationMailer
	default from: "no-reply@aims.uk.com"

	def booking_added(name, booking_email, campaign, web_uid, opp_uid, payment_method)
		@name = name
		@email = booking_email
		@campaign = campaign.Name
		@web_uid = web_uid
		@opp_uid = opp_uid
		@payment_method = payment_method
		mail(to: "walzerfan@yahoo.com",
			subject: "A new booking for #{@campaign} has been submitted")
	end

	def confirm_booking(name, booking_email, campaign, opp_uid, service_fee, payment_after_service, payment, payment_method, amount_due, half_amount_remain, product_description)
		@name = @name
		@email = booking_email
		@campaign = campaign.Name
		@opp_uid = opp_uid
		@service_fee
		@payment_after_service
		@payment = payment
		@payment_method = payment_method
		@amount_due = amount_due
		@half_amount_remain = half_amount_remain
		@page = Page.where(title: whats_next_page_title(campaign.Sub_Type__c)).first
		@bank_details_page = Page.where(title: "Bank Transfer Details").first
		@product_description = product_description
		mail(to: @email,
			subject: "Booking Submitted: #{@campaign}")
	end

	def confirm_payment(email, stripe_id, product_description, amount, service_fee, total_payment)
		@email = email
		@product_description = product_description
		@amount = amount
		@service_fee = service_fee
		@total_paid = total_payment
		@stripe_id = stripe_id
		mail(to: @email,
			subject: "AIMS - Payment confirmation")
	end

	private

	def whats_next_page_title(campaign_type)
		"Whats Next #{campaign_type}"
	end
end
