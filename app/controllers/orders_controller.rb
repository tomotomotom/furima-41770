class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_purchased, only: [:index, :create]
  before_action :redirect_if_owner, only: [:index, :create]

  def index
    @order_form = OrderForm.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @order_form = OrderForm.new(order_params)
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
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
      :phone_number
      ).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
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
