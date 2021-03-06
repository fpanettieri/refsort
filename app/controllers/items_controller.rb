class ItemsController < ApplicationController
  before_action :check_collection
  before_action :set_back, only: [:new, :edit]
  before_action :by_secret, only: [:edit, :update, :destroy]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.collection_id = @collection.id
    if @item.save
      redirect_to edit_collection_path(@collection.secret)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
    redirect_to edit_collection_path(@collection.secret), notice: 'Item updated.'
  end

  def destroy
    @item.destroy
    head 200
  end

  private
    def check_collection
      @collection = Collection.find_by(secret: params[:collection_id])
      redirect_to root_path if @collection.nil?
    end

    def set_back
      @back_url = edit_collection_path(@collection.secret)
    end

    def by_secret
      @item = Item.find_by(secret: params[:id])
      redirect_to edit_collection_path(@collection.secret) if @item.nil?
    end

    def item_params
      params.permit(:name, :img)
    end
end
