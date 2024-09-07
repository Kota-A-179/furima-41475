class PurchasesController < ApplicationController
  before_action :set_item_params

  def index
    @purchase_address =PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def purchase_address_params
    params.require(:purchase_address).permit(:item_id, :post_code, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id).merge(item_id: @item.id).merge(token: params[:token])
  end

  def set_item_params
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = "sk_test_2d999fa97b61415174b9600e"
    Payjp::Charge.create(
      amount: @item.price,
      card: @purchase_address.token,
      currency: 'jpy'
    )
  end
end
