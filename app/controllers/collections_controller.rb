class CollectionsController < ApplicationController
  def index
    @collections = Collection.where(private: false, approved: true)
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      CollectionMailer.new_collection_email(@collection.name, @collection.description, @collection.secret, params[:email]).deliver!
      redirect_to edit_collection_path(@collection.secret)
    else
      render "new"
    end
  end

  def edit
    @collection = Collection.find_by(secret: params[:id])
  end

  def update
    @collection = Collection.find(params[:id])
    @collection.update(collection_params)
    redirect_to edit_collection_path(@collection.secret), notice: 'Collection updated.'
  end

  def destroy
    @collection = Collection.find_by(secret: params[:id])
    @collection.destroy
    redirect_to root_path
  end

  private
    def collection_params
      params.permit(:name, :description, :private, :img)
    end
end
