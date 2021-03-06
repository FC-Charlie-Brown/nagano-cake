class Admin::ItemsController < ApplicationController
  def index
      @items = Item.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(params[:id])
    else
      render :edit
    end
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
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

