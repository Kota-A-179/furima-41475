require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品の出品機能" do
    context "商品を出品できる場合" do
      it "全てのフォームに適切な値が入力されていれば保存できる" do
        expect(@item).to be_valid
      end
    end
    context "商品を出品できない場合" do  
      it '商品画像が添付されていないと保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を挿入してください")
      end

      it '商品名が空だと保存できない' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
  
      it '商品名が40文字を超えると保存できない' do
        @item.name = "a" * 41
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名は40字以内で入力してください")
      end
  
      it '商品説明が空だと保存できない' do
        @item.content = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
  
      it '商品説明が1000文字を超えると保存できない' do
        @item.content = "a" * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明は1000字以内で入力してください")
      end
  
      it 'カテゴリーが未選択（idが1）だと保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end

      it '商品の状態が未選択（idが1）だと保存できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end

      it '配送料の負担が未選択（idが1）だと保存できない' do
        @item.expense_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end

      it '発送元の地域が未選択（idが1）だと保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end

      it '発送までの日数が未選択（idが1）だと保存できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end
  
      it '価格が空だと保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end

      it '価格が全角数字だと保存できない' do
        @item.price = "１０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は半角数字を用いて、300円～999万999円の範囲で設定してください")
      end
  
      it '価格が300円未満だと保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は半角数字を用いて、300円～999万999円の範囲で設定してください")
      end
  
      it '価格が9999999円を超えると保存できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は半角数字を用いて、300円～999万999円の範囲で設定してください")
      end

      it 'userが紐づいていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
