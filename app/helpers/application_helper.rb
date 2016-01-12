module ApplicationHelper

	def from_to(datetime1, datetime2)
		if datetime1.present? && datetime2.present?
			if datetime1.strftime("%m") == datetime2.strftime("%m")
				datetime1.strftime("%d") + " - " + datetime2.to_s(:dmy)
			else
				datetime1.strftime(:dm) + " - " + datetime2.to_s(:dmy)
			end
		end
	end

	def d_m_y(datetime)
		datetime.strftime("%d-%m-%Y") if datetime.present?
	end

	def time_of_date(datetime)
		datetime.strftime("%H:%M") if datetime.present?
	end

	def state_icon(state)
		"#{state}.png"
	end

	def multiple_photos_save(object, photo_attribute_params)
    	photo_attribute_params['image'].each do |image|
      		object.photos.create(image: image)
    	end
 	end

  
  	def link_to_add_fields(name, f, association)
	    new_object = f.object.send(association).klass.new
	    id = new_object.object_id
	    fields = f.fields_for(association, new_object, child_index: id) do |builder|
	      render(association.to_s.singularize + "_fields", :f => builder)
	    end
    	link_to(name, '#', :class => 'add_fields', data: {id: id, fields: fields.gsub("\n", "")})
  	end

end
