class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :condition_id, :expense_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end
end
