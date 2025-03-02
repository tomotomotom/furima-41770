class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [ :index,:new, :create]
  before_action :set_item, only: [:index,:new, :create]
  before_action :redirect_if_purchased, only: [:index, :new, :create]
  before_action :redirect_if_owner, only: [:index, :new, :create]

  def index
    @order_form = OrderForm.new
  end

  def new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
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
end
