class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_purchased, only: [:index, :create]
  before_action :redirect_if_owner, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      if @order_form.save
        redirect_to root_path
      else
        Rails.logger.info("OrderForm save failed")
        Rails.logger.info(@order_form.errors.full_messages)  # エラーメッセージをログに出力
        render :index, status: :unprocessable_entity
      end
    else
      Rails.logger.info("OrderForm validation failed")
      Rails.logger.info(@order_form.errors.full_messages)  # エラーメッセージをログに出力
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end
  
  private

  def order_params
    params.require(:order_form).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :addresses,
      :building,
      :phone_number,
      :token
      ).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_purchased
    if @item.purchase_record.present?
      redirect_to root_path
    end
  end

  def redirect_if_owner
    redirect_to root_path if @item.user_id == current_user.id
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
