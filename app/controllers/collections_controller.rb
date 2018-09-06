class CollectionsController < ApplicationController
  def index
    @collections = Collection.where(private: false)
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      redirect_to edit_collection_path(@collection.secret)
    else
      render "new"
    end
  end

  private
    def collection_params
      params.permit(:name, :description, :private, :img)
    end
end
