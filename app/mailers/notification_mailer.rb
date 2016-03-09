class NotificationMailer < ApplicationMailer
	default from: "no-reply@aims.uk.com"

	def booking_added(first_name, last_name, booking_email)
		@first_name = first_name
		@last_name = last_name
		@email = booking_email
		mail(to: "walzerfan@yahoo.com",
			subject: "A new booking has been submitted")
	end

	def confirm_booking(first_name, last_name, booking_email, campaign)
		@first_name = first_name
		@last_name = last_name
		@email = booking_email
		@campaign = campaign
		@page_content = Page.where(title: whats_next_page_title(@campaign))
		mail(to: @email,
			subject: "Booking Confrimation: #{@campaign}")
	end

	private

	def whats_next_page_title(campaign)
		"Whats Next #{campaign}"
	end
end
