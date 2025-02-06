class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :sales_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :category
  belongs_to :scheduled_delivery

  validates :category_id, numericality: { other_than: 1 } 
  validates :sales_status_id, numericality: { other_than: 1 } 
  validates :shipping_fee_id, numericality: { other_than: 1 } 
  validates :prefecture_id, numericality: { other_than: 1 } 
  validates :scheduled_delivery_id, numericality: { other_than: 1 } 

  with_options presence: true do
    validates :name
    validates :info
    validates :price
  end
end
