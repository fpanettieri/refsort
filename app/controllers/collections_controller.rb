class CollectionsController < ApplicationController
  before_action :set_back, only: [:new, :edit]
  before_action :by_slug, only: [:show]
  before_action :by_secret, only: [:edit, :update, :destroy]

  def index
    @collections = Collection.where(priv: false, approved: true)
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    if verify_recaptcha(model: @collection) && @collection.save
      CollectionMailer.new_collection_email(@collection.name, @collection.description, @collection.slug, @collection.secret, params[:email]).deliver!
      redirect_to edit_collection_path(@collection.secret)
    else
      render "new"
    end
  end

  def show
    # TODO: vote or results
  end

  def edit
    @back_url = root_path
  end

  def update
    @collection.update(collection_params)
    redirect_to edit_collection_path(@collection.secret), notice: 'Collection updated.'
  end

  def destroy
    @collection.destroy
    head 200
  end

  private
    def set_back
      @back_url = root_path
    end

    def by_slug
      @collection = Collection.find_by(slug: params[:id])
      redirect_to root_path if @collection.nil?
    end

    def by_secret
      @collection = Collection.find_by(secret: params[:id])
      redirect_to root_path if @collection.nil?
    end

    def collection_params
      params.permit(:name, :description, :priv, :img)
    end
end
