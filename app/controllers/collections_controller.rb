class CollectionsController < ApplicationController
  def index
    @collections = Collection.where(private: false)
  end

  def new
    @collection = Collection.new
  end
end
