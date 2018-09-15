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

    def create_variants
      return unless self.img.attached?
      self.img.variant(resize: 512).processed
      self.img.variant(resize: 64).processed
    end
end
