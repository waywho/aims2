class Document < ActiveRecord::Base
	mount_uploader :file, DocUploader
end
