require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できるとき' do
    it '必要情報が満たされていれば出品できる' do
      expect(@item).to be_valid
    end
  end

  context '商品出品できないとき' do
    it '商品名が空では出品できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品説明が空では出品できない' do
      @item.info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Info can't be blank")
    end

    it '商品のカテゴリーがーーーでは出品できない' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it '商品の状態がーーーでは出品できない' do
      @item.sales_status_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Sales status can't be blank")
    end

    it '配送料がーーーでは出品できない' do
      @item.shipping_fee_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
    end

    it '発送元がーーーでは出品できない' do
      @item.prefecture_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '発送時期がーーーでは出品できない' do
      @item.scheduled_delivery_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
    end

    it '商品価格が空欄では出品できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '商品価格が300円未満では出品できない' do
      @item.price = '299'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end

    it '商品価格が10000000円以上では出品できない' do
      @item.price = '10000000'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end

    it '価格が半角数値でない場合は保存できない' do
      @item.price = '３０００'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it '商品の画像がない状態では出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it 'ユーザーが紐づいていないと出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end

  end
end
end
