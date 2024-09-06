class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase_address =PurchaseAddress.new
  end
end
