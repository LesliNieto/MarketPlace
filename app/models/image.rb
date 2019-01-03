class Image < ApplicationRecord
  belongs_to :product
  has_attached_file :image, styles: { medium: "1200x1200 ", thumb: "128x128 " }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
