class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_params, only: [:show, :edit, :update]
  def index
    @items = Item.order(created_at: :DESC).includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show 
  end

  def edit
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end


  private
  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :condition_id, :expense_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_params
    @item = Item.find(params[:id])
  end
end
