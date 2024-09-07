require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    @purchase_address = FactoryBot.build(:purchase_address, item_id: item.id, user_id: user.id)
  end


  describe "商品の購入機能" do
    context '商品の購入ができる場合' do
      it '全ての項目に適切な値が入力されていれば保存できる' do
        expect(@purchase_address).to be_valid
      end
      
      it '建物名が空でも保存できる' do
        @purchase_address.building = ""
        expect(@purchase_address).to be_valid
      end

      it '電話番号が11桁の数字でも保存できる' do
        @purchase_address.phone_number = "12345678901"
        expect(@purchase_address).to be_valid
      end
    end
  
    context '商品の購入ができない場合' do
      it 'item_idが空では保存できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("商品IDを入力してください")
      end
  
      it 'user_idが空では保存できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("ユーザーIDを入力してください")
      end
  
      it '郵便番号が空では保存できない' do
        @purchase_address.post_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it '郵便番号に全角数字が入力されていては保存できない' do
        @purchase_address.post_code = "１１１-3333"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号は半角数字でハイフン(-)を含めて入力してください")
      end

      it '郵便番号の4文字目にハイフン(-)がなければ保存できない' do
        @purchase_address.post_code = "1234-567"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号は半角数字でハイフン(-)を含めて入力してください")
      end

      it '郵便番号のハイフン(-)の後の文字数が３文字以下では保存できない' do
        @purchase_address.post_code = "123-456"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号は半角数字でハイフン(-)を含めて入力してください")
      end

      it '郵便番号のハイフン(-)の後の文字数が５文字以上では保存できない' do
        @purchase_address.post_code = "123-56789"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号は半角数字でハイフン(-)を含めて入力してください")
      end
  
      it '都道府県が未選択では保存できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("都道府県を選択してください")
      end
  
      it '市区町村が空では保存できない' do
        @purchase_address.city = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("市区町村を入力してください")
      end
  
      it '番地が空では保存できない' do
        @purchase_address.block = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("番地を入力してください")
      end
  
      it '電話番号が空では保存できない' do
        @purchase_address.phone_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it '電話番号に全角数字が入力されていては保存できない' do
        @purchase_address.phone_number = '０９０12345678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は半角数字でハイフン(-)を含めず入力してください")
      end

      it '電話番号が９文字以下では保存できない' do
        @purchase_address.phone_number = '090123456'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は半角数字でハイフン(-)を含めず入力してください")
      end

      it '電話番号が１２文字以上では保存できない' do
        @purchase_address.phone_number = '090123456781'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は半角数字でハイフン(-)を含めず入力してください")
      end
  
      it '電話番号にハイフン(-)が含まれていては保存できない' do
        @purchase_address.phone_number = '090-1234-5678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は半角数字でハイフン(-)を含めず入力してください")
      end

      it 'クレジットカード情報が空では保存できない' do
        @purchase_address.token = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end