class Admin::ItemsController < ApplicationController
  def index
      @items = Item.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def update
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
    # redirect_to admin_items_path
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  private
  def item_params
     params.require(:item).permit(:name, :introduction, :price, :image, :sale_status, :genre_id)
  end
end

