# Preview all emails at http://localhost:3000/rails/mailers/collection_mailer
class CollectionMailerPreview < ActionMailer::Preview
  def new_collection_email
    @collection = Collection.first
    CollectionMailer.new_collection_email(@collection.name, @collection.description, @collection.secret, 'test@mailinator.com')
  end
end
