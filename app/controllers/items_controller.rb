class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update ,:destroy]
  before_action :set_item, only: [:edit, :show, :update ,:destroy]
  before_action :redirect_if_purchased, only: [:edit, :update]


  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new ,status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit ,status: :unprocessable_entity
    end
  end

  def destroy
    if @item.user == current_user
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :info,
      :category_id,
      :sales_status_id,
      :shipping_fee_id,
      :prefecture_id,
      :scheduled_delivery_id,
      :price,
      :image
      ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_if_purchased
    if @item.purchase_record.present?
      redirect_to root_path
    end
  end

end
