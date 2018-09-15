class Collection < ApplicationRecord
  include Sluggable
  include Secretable

  has_many :items, dependent: :destroy

  validates :name, presence: true, length: {maximum: 40}, allow_nil: false
  validates :description, length: {maximum: 100}, allow_nil: true

  has_one_attached :img
  #has_attached_file :img, styles: { medium: "400x600>" }, default_url: "https://placeimg.com/400/600/any"
  #validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/

  def calc_order
    c = items.count
    s = items.sum(:votes)
    s.fdiv(2).fdiv(c * c)
  end

  def tweet!
    @@client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
    @url = "https://refsort.com/#{self.slug}"
    @file = Paperclip.io_adapters.for(self.img.styles[:medium])
    @@client.update_with_media("New Collection: #{self.name}\n\n#{self.description}\n\n#{@url}", File.open(@file.path))
  end
end
