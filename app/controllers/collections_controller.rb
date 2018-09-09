class CollectionsController < ApplicationController
  before_action :by_secret, only: [:show, :edit, :update, :destroy]

  def index
    @collections = Collection.where(private: false, approved: true)
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      CollectionMailer.new_collection_email(@collection.name, @collection.description, @collection.slug, @collection.secret, params[:email]).deliver!
      redirect_to edit_collection_path(@collection.secret)
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    @collection.update(collection_params)
    redirect_to edit_collection_path(@collection.secret), notice: 'Collection updated.'
  end

  def destroy
    @collection.destroy
    redirect_to root_path
  end

  def sort
    @collection = Collection.find_by(slug: params[:slug])
    redirect_to root_path if @collection.nil?
  end

  private
    def by_secret
      @collection = Collection.find_by(secret: params[:id])
      redirect_to root_path if @collection.nil?
    end

    def collection_params
      params.permit(:name, :description, :private, :img)
    end
end
