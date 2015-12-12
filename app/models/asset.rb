class Asset < ActiveRecord::Base
	belongs_to :recipe
	has_attached_file :image
end
