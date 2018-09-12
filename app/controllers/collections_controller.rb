class CollectionsController < ApplicationController
  before_action :set_back, only: [:new, :edit, :show]
  before_action :by_slug, only: [:show]
  before_action :by_secret, only: [:edit, :update, :destroy, :results]

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
    @a = pick_rand(@collection.items)
    @b = pick_rand(@collection.items.where.not(id: @a.id))
  end

  def vote
    # TODO: implement this
  end

  def edit
  end

  def update
    @collection.update(collection_params)
    redirect_to edit_collection_path(@collection.secret), notice: 'Collection updated.'
  end

  def results
    @order = @collection.calc_order
    @back_url = edit_collection_path(@collection.secret)
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

    def pick_rand(items)
      min = items.minimum(:views)
      items.where(views: min).order("RAND()").limit(1).first
    end
end
