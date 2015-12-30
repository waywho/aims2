json.array!(@course_formats) do |course_format|
  json.extract! course_format, :id
  json.url course_format_url(course_format, format: :json)
end
