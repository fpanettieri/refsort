class CollectionsController < ApplicationController
  before_action :by_slug, only: [:show, :vote]
  before_action :by_secret, only: [:edit, :update, :destroy, :results]
  before_action :set_order, only: [:show, :results]
  before_action :set_back, only: [:new, :edit, :show]

  def index
    @collections = Collection.where(priv: false)
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    if verify_recaptcha(model: @collection) && @collection.save
      deliver_external_notifications
      redirect_to edit_collection_path(@collection.secret)
    else
      render "new"
    end
  end

  def show
    @a = pick_rand(@collection.items)
    @b = pick_rand(@collection.items.where.not(id: @a.try(:id)))
  end

  def vote
    @a = pick_item(@collection.items, params[:a])
    @b = pick_item(@collection.items, params[:b])
    redirect_to root_path if (@a.nil? or @b.nil?)

    @voted = @a.slug.eql?(params[:v]) ? @a : @b

    @a.increment(:views)
    @b.increment(:views)
    @voted.increment(:votes)

    head (@a.save && @b.save) ? 200 : 500
  end

  def edit
  end

  def update
    @collection.update(collection_params)
    redirect_to edit_collection_path(@collection.secret), notice: 'Collection updated.'
  end

  def results
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

    def set_order
      @order = @collection.calc_order
    end

    def by_slug
      @collection = Collection.includes(:items).find_by(slug: params[:id])
      redirect_to root_path if @collection.nil?
    end

    def by_secret
      @collection = Collection.includes(:items).find_by(secret: params[:id])
      redirect_to root_path if @collection.nil?
    end

    def collection_params
      params.permit(:name, :description, :priv, :img)
    end

    def pick_rand(items)
      min = items.minimum(:views)
      items.where(views: min).order("RAND()").limit(1).first
    end

    def pick_item(items, slug)
      items.where(slug: slug).first
    end

    def deliver_external_notifications
      Thread.new do
        Rails.application.executor.wrap do
          CollectionMailer.new_collection_email(@collection.name, @collection.description, @collection.slug, @collection.secret, params[:email]).deliver!
          @collection.tweet! unless @collection.priv
        end
      end
    end
end
