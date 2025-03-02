FactoryBot.define do
  factory :order_form do
    postal_code { '123-4567' }
    prefecture_id { '2' }
    city { '横浜市' }
    addresses { '青山1-1-1'}
    building { '柳ビル103' }
    phone_number { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}

    # 外部キーに関連する設定も必要に応じて追加します
    user_id { 1 }
    item_id { 1 }
  end
end
