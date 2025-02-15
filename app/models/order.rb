class Order < ApplicationRecord
  belongs_to :purchase_record

  validates :postal_code,presence:true
  validates :prefecture_id,numericality: { other_than: 1 ,message: "can't be blank"}
  validates :city,presence:true
  validates :addresses,presence:true
  validates :building,presence:true
  validates :phone_number,presence:true

end
