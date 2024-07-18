class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :burden_of_shipping_charges
  belongs_to :delivery_region
  belongs_to :estimated_delivery_date
  belongs_to_active_hash :burden_of_shipping_charges
  has_one_attached :image

  validates :image, presence: true
  validates :product_name, presence: true
  validates :product_description, presence: true
  validates :category_id, numericality: { other_than: 1 }
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, allow_blank: true, only_integer: true }
  validates :product_condition_id, numericality: { other_than: 1 }
  validates :burden_of_shipping_charges_id, numericality: { other_than: 1 }
  validates :delivery_region_id, numericality: { other_than: 1 }
  validates :estimated_delivery_date_id, numericality: { other_than: 1 }

  belongs_to :user
end
