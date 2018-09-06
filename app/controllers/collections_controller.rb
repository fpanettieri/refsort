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
      # redirect to admin collection
      redirect_to @collection
    else
      render "new"
    end
  end

  private
    def collection_params
      params.permit(:name, :description, :private, :img)
    end
end
