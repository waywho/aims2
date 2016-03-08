class NotificationMailer < ApplicationMailer
	default from: "test@aims.uk.com"

	def booking_added
		mail(to: 'walzerfan@yahoo.com',
			subject: "A new booking has been submitted")
	end
end
