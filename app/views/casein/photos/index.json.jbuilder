json.array! @photos do |photo|
 json.url photo.image_url
 json.thumb photo.image_url(:thumb).to_s
 json.tag photo.caption
end