class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params.merge(user_id: current_user.id))
  
    if @item_form.valid?
      @item_form.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
    @item_form.tag_name = @item.tags.first&.tag_name
  end

  def update
    @item = Item.find(params[:id])
    
    # 新しいItemFormオブジェクトを作成し、既存の画像を保持
    @item_form = ItemForm.new(item_form_params)
  
    # 画像が送信されなかった場合は既存の画像をセット
    if item_form_params[:images].blank?
      @item_form.images = @item.images.attachments.map(&:blob)
    end
  
    # 画像を含めたその他の属性を更新
    if @item_form.valid?
      @item_form.update(item_form_params, @item)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :content, :product_name, :category_id, :price, :product_condition_id,
      :burden_of_shipping_charges_id, :delivery_region_id, :estimated_delivery_date_id, :product_description, images: []
    ).merge(user_id: current_user.id)
  end
  
  def correct_user
    if @item.purchase_record.present? || current_user.id != @item.user_id
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_form_params
    params.require(:item_form).permit(:content, :product_name, :category_id, :price, :product_condition_id,
    :burden_of_shipping_charges_id, :delivery_region_id, :estimated_delivery_date_id, :product_description, :tag_name, images: []
  ).merge(user_id: current_user.id)
  end

end
