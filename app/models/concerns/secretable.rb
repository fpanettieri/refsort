module Secretable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_secret

    private
      def generate_secret
        self.secret = SecureRandom.urlsafe_base64 64 if self.secret.blank?
      end
  end
end
