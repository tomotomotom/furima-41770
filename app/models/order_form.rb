class OrderForm
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id, :token
 
  with_options presence: true do
  validates :postal_code,format:  { with: /\A\d{3}-\d{4}\z/, message: 'は「000-0000」の形式で入力してください' }
  validates :city
  validates :addresses
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁または11桁の半角数字で入力してください" }
  validates :user_id
  validates :item_id
  validates :token
  end
  validates :prefecture_id,numericality: { other_than: 1 ,message: "can't be blank"}


  def save
     return false unless valid?

    ActiveRecord::Base.transaction do
      purchase_record = PurchaseRecord.create!(
        user_id: user_id,
        item_id: item_id
      )

      puts "PurchaseRecord created: #{purchase_record.id}"  # デバッグ情報
      
      Order.create!(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        addresses: addresses,
        building: building,
        phone_number: phone_number,
        purchase_record_id: purchase_record.id,
        user_id: user_id
      )
      puts "Order created with purchase_record_id: #{purchase_record.id}"  # デバッグ情報
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    puts "Error: #{e.message}"  # デバッグ情報
    false
  end
end