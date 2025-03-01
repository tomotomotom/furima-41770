class OrderForm
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id, :purchase_record_id
 
  with_options presence: true do
  validates :postal_code
  validates :city,format: { with: /\A\d{3}-\d{4}\z/, messaformat: { with: /\A\d{3}-\d{4}\z/, message: "は「000-0000」の形式で入力してください" } }
  validates :addresses
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁または11桁の半角数字で入力してください" }
  validates :user_id
  validates :item_id
  end
  validates :prefecture_id,numericality: { other_than: 1 ,message: "can't be blank"}


  def save
    
    PurchaseRecord.create(
      user_id: user_id,
      item_id: item_id
    )

    order = Order.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      purchase_record_id: purchase_record.id
    )
  end
end