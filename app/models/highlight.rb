class Highlight < ActiveRecord::Base
  belongs_to :courseformat
  acts_as_xlsx
end
