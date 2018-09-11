class Item < ApplicationRecord
  belongs_to :collection

  include Sluggable
  include Secretable

  has_attached_file :img, styles: { large: "1200x1200>", medium: "512x512>", thumb: "64x64>" }, default_url: "https://placeimg.com/600/600/any"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/
end
