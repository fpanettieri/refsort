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
      redirect_to edit_collection_path(@collection.secret)
    else
      render "new"
    end
  end

  def edit
    @collection = Collection.find_by(secret: params[:id])
  end

  private
    def collection_params
      params.permit(:name, :description, :private, :img)
    end
end
