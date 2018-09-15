class Item < ApplicationRecord
  include Sluggable
  include Secretable

  belongs_to :collection

  has_attached_file :img, styles: { large: "1200x1200>", medium: "512x512>", thumb: "64x64>" }, default_url: "https://placeimg.com/600/600/any"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/

  before_save :update_score

  private
    def update_score
      return if self.views == 0
      self.score = self.votes.fdiv(self.views) * 10.0
    end
end
