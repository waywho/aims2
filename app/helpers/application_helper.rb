module ApplicationHelper
	def truncated_description(description)
		output = truncate(description, length: 160, separator: " ", escape: false)
		output.html_safe
	end

	def truncated_blurb(description)
		output = truncate(description, length: 100, separator: " ", escape: false)
		output.html_safe
	end

	def truncated_feature(description, link)
		output = truncate(description, length: 250, separator: " ", escape: false) {link_to "continue", link}
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

	def d_m_y(datetime)
		datetime.strftime("%d-%m-%Y") if datetime.present?
	end


	def d_Month_y(datetime)
		datetime.strftime("%d %B, %Y") if datetime.present?
	end

	def event_datetime(datetime)
		datetime.strftime("%A, %d %B, %Y  |  %I:%M %p") if datetime.present?
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

 	def published_news?
 		NewsItem.published_now.size > 0
 	end
  
  	def link_to_add_fields(name, f, association)
	    new_object = f.object.send(association).klass.new
	    id = new_object.object_id
	    fields = f.fields_for(association, new_object, child_index: id) do |builder|
	      render(association.to_s.singularize + "_fields", :f => builder)
	    end
    	link_to(name, '#', :class => 'add_fields', data: {id: id, fields: fields.gsub("\n", "")})
  	end

  	def current_user
 		@current_user ||= User.find(session[:user_id]) if sesson[:user_id]
 	end

 	def nav_link(link_text, link_path)
  		class_name = current_page?(link_path) ? 'active' : ''

  		content_tag(:li, :class => class_name) do
    		link_to link_text, link_path
  		end
	end

	def regrouped_staffs(staffs)
		@regrouped_staffs = Hash.new
		staffs.group_by(&:role).each_pair do |role, staffs|
			if !Staff::ADMIN_ROLES.include?(role)
				@regrouped_staffs.merge!(:"Admin Staff" => staffs){ |k, nv, ov| nv + ov}
			else
				@regrouped_staffs.merge!(role => staffs){ |k, nv, ov| nv + ov}
			end
		
		end
		@regrouped_staffs
	end
end
