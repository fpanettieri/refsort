class CollectionMailer < ApplicationMailer
  def new_collection_email(name, description, slug, secret, email)
    @name = name
    @description = description
    @email = email
    @secret  = "https://refsort.com/collections/#{secret}/edit"
    @sort  = "https://refsort.com/#{slug}"
    mail(to: @email, from: 'RefSort <no-reply@refsort.com>', subject: "New Collection: #{@name}")
  end
end
