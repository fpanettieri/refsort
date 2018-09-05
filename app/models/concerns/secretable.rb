module Secretable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_secret

    private
      def generate_slug
        self.secret = SecureRandom.urlsafe_base64 32 if self.slug.blank?
      end
  end
end
