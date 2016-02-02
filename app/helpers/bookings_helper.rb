module BookingsHelper
	def sf_session_options(fields, selection, controllingField, client)
		field = fields.find { |f| f['controllerName'] == controllingField }
		if field.present?
 			client.picklist_values('Opportunity', field['name'], :valid_for => selection)
 		end
 	end

 	def sf_session2_options(client, selection)
 		client.picklist_values('Opportunity', 'Session_2_Options__c', :valid_for => selection)
 	end

 	def sf_session3_options(client, selection)
 		client.picklist_values('Opportunity', 'Session_3_Options__c', :valid_for => selection)
 	end

 	def sf_session4_options(client, selection)
 		client.picklist_values('Opportunity', 'Session_4_Options__c', :valid_for => selection)
 	end
end
