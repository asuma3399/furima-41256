class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :correct_user, only: :edit
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:content, :image, :product_name, :category_id, :price, :product_condition_id,
                                 :burden_of_shipping_charges_id, :delivery_region_id, :estimated_delivery_date_id, :product_description).merge(user_id: current_user.id)
  end

  def correct_user
    item = Item.find(params[:id])
    unless current_user.id == item.user_id
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
