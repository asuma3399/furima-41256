require 'rails_helper'

RSpec.describe PurchaseRecordShippingAddress, type: :model do
  before do
    @purchase_record_shipping_address = FactoryBot.build(:purchase_record_shipping_address)
  end

  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_record_shipping_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @purchase_record_shipping_address.building_name = nil
        expect(@purchase_record_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が必須である' do
        @purchase_record_shipping_address.post_code = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages). to include("Post code can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能である' do
        @purchase_record_shipping_address.post_code = "1234567"
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it '都道府県が必須である' do
        @purchase_record_shipping_address.delivery_region_id = 1
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Delivery region must be other than 1")
      end
      it '市区町村が必須である' do
        @purchase_record_shipping_address.municipality = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が必須である' do
        @purchase_record_shipping_address.street_address = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Street address can't be blank")
      end
      it '電話番号が必須である' do
        @purchase_record_shipping_address.telephone_number = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能である' do
        @purchase_record_shipping_address.telephone_number = 123456789
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it 'tokenが空では登録できないこと' do
        @purchase_record_shipping_address.token = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
