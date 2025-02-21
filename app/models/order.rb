class Order < ApplicationRecord
  belongs_to :purchase_record
  belongs_to :user

  validates :postal_code,presence:true
  validates :prefecture_id,numericality: { other_than: 1 ,message: "can't be blank"}
  validates :city,presence:true,format: { with: /\A\d{3}-\d{4}\z/, messaformat: { with: /\A\d{3}-\d{4}\z/, message: "は「000-0000」の形式で入力してください" } }
  validates :addresses,presence:true
  validates :phone_number,presence:true, format: { with: /\A\d{10,11}\z/, message: "は10桁または11桁の半角数字で入力してください" }

end
