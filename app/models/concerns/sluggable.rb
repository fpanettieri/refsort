module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_slug

    private
      def generate_slug
        self.slug = SecureRandom.urlsafe_base64 16 if self.slug.blank?
      end
  end
end
