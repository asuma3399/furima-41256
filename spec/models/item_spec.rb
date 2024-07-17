require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do
    context '商品が出品できる場合' do
      it '画像、商品名、商品の説明、カテゴリー、商品の状態、配送料の負担、発送元の地域、発送までの日数、販売価格¥300~¥9,999,999の間が入力されていれば商品が出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品が出品できない場合' do
      it '画像がついていなければ出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が入力されていなければ出品できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it '商品の説明が入力されていなければ出品できない' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product description can't be blank")
      end
      it 'カテゴリーは「---」が選択されている場合は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it '商品の状態は「---」が選択されている場合は出品できない' do
        @item.product_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Product condition must be other than 1')
      end
      it '配送料の負担は「---」が選択されている場合は出品できない' do
        @item.burden_of_shipping_charges_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Burden of shipping charges must be other than 1')
      end
      it '発送元の地域は「---」が選択されている場合は出品できない' do
        @item.delivery_region_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery region must be other than 1')
      end
      it '発送までの日数は「---」が選択されている場合は出品できない' do
        @item.estimated_delivery_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Estimated delivery date must be other than 1')
      end
      it '販売価格に金額が入力されていない場合は出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が¥300未満の価格が入力されている場合は出品できない' do
        @item.price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '販売価格が¥9,999,999以上の価格が入力されている場合は出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '販売価格に数字以外の文字が入力されている場合は出品できない' do
        @item.price = 'テスト'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '販売価格に全角数字が入力されている場合は出品できない' do
        @item.price = '１'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
