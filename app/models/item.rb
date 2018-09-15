class Item < ApplicationRecord
  include Sluggable
  include Secretable

  belongs_to :collection
  has_one_attached :img
  before_save :update_score
  after_save :create_variants

  private
    def update_score
      self.score = self.votes.fdiv(self.views.to_f) * 10.0
    end

    # has_attached_file :img, styles: { large: "1200x1200>", medium: "512x512>", thumb: "64x64>" }, default_url: "https://placeimg.com/600/600/any"
    # validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/

    def create_variants
      return unless self.img.attached?
      self.img.variant(resize_to_fit: [512, 512])
      self.img.variant(resize_to_fit: [64, 64])
    end
end
