class Collection < ApplicationRecord
  has_attached_file :img, styles: { medium: "200x300>", img: "64x64>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/
end
