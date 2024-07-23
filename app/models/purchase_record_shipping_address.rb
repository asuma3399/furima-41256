class PurchaseRecordShippingAddress
  include ActiveModel::Model
  attr_accessor :post_code, :delivery_region_id, :municipality, :street_address, :building_name, :telephone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :delivery_region_id, numericality: { other_than: 1 }
    validates :municipality
    validates :street_address
    validates :telephone_number, format: { with: /\A\d{10,11}\z/}
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(post_code: post_code, delivery_region_id: delivery_region_id, municipality: municipality, street_address: street_address, building_name: building_name, telephone_number: telephone_number, purchase_record_id: order.id)
  end
end