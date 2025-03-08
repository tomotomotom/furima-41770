require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @order_form = FactoryBot.build(:order_form)
  end

  describe '商品購入' do
    context '商品購入できるとき' do
    it '必要情報が満たされていれば購入できる' do
      expect(@order_form).to be_valid
    end

    it '建物情報が空でも購入できる' do
      @order_form.building = ''
      expect(@order_form).to be_valid
    end
  end

  context '商品購入できないとき' do
    it '郵便番号が空では購入できない' do
      @order_form.postal_code = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号にハイフンが含まれていないと購入できない' do
      @order_form.postal_code = '1234567'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Postal code は「000-0000」の形式で入力してください")
    end

    it '都道府県が必須であること' do
      @order_form.prefecture_id = '1'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '市区町村が必須であること' do
      @order_form.city = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("City can't be blank")
    end

    it '番地が必須であること' do
      @order_form.addresses = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Addresses can't be blank")
    end

    it '電話番号が空では購入できない' do
      @order_form.phone_number = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号が9桁以下では購入できない' do
      @order_form.phone_number = '12345'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number は10桁または11桁の半角数字で入力してください")
    end

    it '電話番号が12桁以上では購入できない' do
      @order_form.phone_number = '123456789012'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number は10桁または11桁の半角数字で入力してください")
    end

    it '電話番号に半角数字以外が含まれている場合、購入できない' do
      @order_form.phone_number = 'abcdefgh'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number は10桁または11桁の半角数字で入力してください")
    end

    it 'クレジットカードのトークンが空欄では購入できない' do
      @order_form.token = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Token can't be blank")
    end

    it 'user_idが空では購入できない' do
      @order_form.user_id = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空では購入できない' do
      @order_form.item_id = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Item can't be blank")
    end
  end
end
end