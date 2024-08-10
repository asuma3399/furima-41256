class ItemForm
  include ActiveModel::Model

  attr_accessor( :images, :product_name, :product_description, :category_id,
    :price, :product_condition_id, :burden_of_shipping_charges_id, :delivery_region_id,
    :estimated_delivery_date_id, :user_id, :id, :created_at, :updated_at, :tag_name
  )

  with_options presence: true do
    validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
    validates :product_name
    validates :product_description
    validates :category_id, numericality: { other_than: 1 }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, allow_blank: true, only_integer: true }
    validates :product_condition_id, numericality: { other_than: 1 }
    validates :burden_of_shipping_charges_id, numericality: { other_than: 1 }
    validates :delivery_region_id, numericality: { other_than: 1 }
    validates :estimated_delivery_date_id, numericality: { other_than: 1 }
  end

  def save
    item = Item.create(images: images, product_name: product_name, product_description: product_description,
                category_id: category_id, price: price, product_condition_id: product_condition_id,
                burden_of_shipping_charges_id: burden_of_shipping_charges_id, delivery_region_id: delivery_region_id,
                estimated_delivery_date_id: estimated_delivery_date_id, user_id: user_id)
    if tag_name.present?
      tag = Tag.where(tag_name: tag_name).first_or_initialize
      tag.save
      ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
    end
  end

  def update(params, item)
    #一度タグの紐付けを消す
    item.item_tag_relations.destroy_all

    #paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
    tag_name = params.delete(:tag_name)

    #もしタグの情報がすでに保存されていればインスタンスを取得、無ければインスタンスを新規作成
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?
    
    # 他の属性を更新
    tag.save if tag_name.present?
    item.update(params.except(:images))
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
  
    # 新しい画像が追加された場合のみ追加
    if params[:images].present?
      item.images.attach(params[:images])
    end
  end
end