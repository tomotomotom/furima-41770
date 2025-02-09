class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :sales_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :category
  belongs_to :scheduled_delivery
  has_one_attached :image

  validates :category_id, numericality: { other_than: 1 ,message: "can't be blank"} 
  validates :sales_status_id, numericality: { other_than: 1 ,message: "can't be blank"} 
  validates :shipping_fee_id, numericality: { other_than: 1 ,message: "can't be blank"} 
  validates :prefecture_id, numericality: { other_than: 1 ,message: "can't be blank"} 
  validates :scheduled_delivery_id, numericality: { other_than: 1 ,message: "can't be blank"} 

  with_options presence: true do
    validates :name
    validates :info
    validates :price,numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999} 
    validates :image

  end

end
