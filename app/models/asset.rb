class Asset < ActiveRecord::Base
  belongs_to :recipe
  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: ':style/no_image_available.jpg'
  validates_attachment_content_type :image, content_type: %r{\Aimage/}
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
end
