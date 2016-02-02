module BookingsHelper
	def sf_session_options(fields, selection, controllingField, client)
		field = fields.find { |f| f['controllerName'] == controllingField }
		if !field.nil?
 			client.picklist_values('Opportunity', field['name'], :valid_for => selection)
 		end
 	end

end
