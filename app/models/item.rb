class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :product_condition
  belongs_to :delivery_region
  belongs_to_active_hash :burden_of_shipping_charges
  belongs_to_active_hash :estimated_delivery_date
  has_one :purchase_record
  has_many :comments
  has_many_attached :images

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
end
