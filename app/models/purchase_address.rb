class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :prefecture_id, :city, :block, :building, :phone_number, :purchase_id, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :city
    validates :block
    validates :phone_number
    validates :token
  end

  validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は半角数字でハイフン(-)を含めて入力してください" }, if: -> { post_code.present? }
  validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: "は半角数字でハイフン(-)を含めず入力してください" }, if: -> { phone_number.present? }

  def save
      purchase = Purchase.create(item_id: item_id, user_id: user_id)
      Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, block: block, phone_number: phone_number, purchase_id: purchase.id)
  end
end
