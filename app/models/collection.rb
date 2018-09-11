class Collection < ApplicationRecord
  has_many :items, dependent: :destroy

  include Sluggable
  include Secretable

  has_attached_file :img, styles: { medium: "400x600>" }, default_url: "https://placeimg.com/400/600/any"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/
end
