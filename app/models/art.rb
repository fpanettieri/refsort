class Art < ApplicationRecord
  has_attached_file :img, styles: { medium: "400x600>", thumb: "80x120>" }, default_url: "https://placeimg.com/800/1200/any"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/
end
