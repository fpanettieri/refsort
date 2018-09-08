class CollectionMailer < ApplicationMailer
  def new_collection_email(name, description, secret, email)
    @name = name
    @description = description
    @email = email
    @url  = "https://refsort.com/collections/#{secret}/edit"
    mail(to: @email, subject: "New Collection: #{@name}")
  end
end
