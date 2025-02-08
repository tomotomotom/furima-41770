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
    validates :price,format: {with: /\A([3-9]\d{2}|[1-9]\d{3,6}|[1-9]\d{0,2}(,\d{3}){1,2})\z/, message: "is invalid. Please enter a valid price between ¥300 and ¥9,999,999 with a yen symbol and only half-width numbers."}
    validates :image

  end

end
