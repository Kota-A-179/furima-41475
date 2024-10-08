class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item_params

  def index
    if @item.purchase.present?
      redirect_to root_path
    elsif current_user.id == @item.user_id
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      @purchase_address =PurchaseAddress.new    
    end 
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private
  def purchase_address_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city, :block, :building, :phone_number).merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
  end

  def set_item_params
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: @purchase_address.token,
      currency: 'jpy'
    )
  end
end
