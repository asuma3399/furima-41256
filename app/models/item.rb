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
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations

end
