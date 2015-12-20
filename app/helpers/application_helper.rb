module ApplicationHelper

	def truncated_description(description)
		output = truncate(description, length: 75, separator: " ")
		output.html_safe
	end
end
