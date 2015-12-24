module ApplicationHelper

	def truncated_description(description)
		output = truncate(description, length: 75, separator: " ")
		output.html_safe
	end

	def from_to(datetime1, datetime2)
		if datetime1.present? && datetime2.present?
			if datetime1.strftime("%m") == datetime2.strftime("%m")
				datetime1.strftime("%d") + " - " + datetime2.to_s(:dmy)
			else
				datetime1.strftime(:dm) + " - " + datetime2.to_s(:dmy)
			end
		end
	end

	def date_time_year(datetime)
		datetime.to_s(:dmy) if datetime.present?
	end
end
