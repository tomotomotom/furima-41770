require 'rails_helper'

RSpec.describe Item, type: :model do
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
      expect(@item.errors.full_messages).to include("Nickname can't be blank")
    end
    it '商品説明が空では出品できない' do
      @item.info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Email can't be blank")
    end
  end
end
end
