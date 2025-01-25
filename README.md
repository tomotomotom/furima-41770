# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## usersテーブル
| Column              | Type      | Options                  |
|---------------------|-----------|--------------------------|
| nickname            | string    | null:false               |
| email               | string    | null:false, unique: true |
| password            | string    | null:false               |
| last_name           | string    | null:false               |
| first_name          | string    | null:false               |
| last_name_kana      | string    | null:false               |
| first_name_kana     | string    | null:false               |
| birth_date          | date      | null:false               |


### Association
has_many :items
has_many :orders
belongs_to :purchase_record

---

## itemsテーブル
| Column                   | Type      | Options                      |
|--------------------------|-----------|------------------------------|
| item_name                | string    | null:false                   |
| item_info                | text      | null:false                   |
| item_category            | integer   | null:false                   |
| item-sales-status        | integer   | null:false                   |
| item_shipping_fee_status | integer   | null:false                   |
| item_prefecture          | integer   | null:false                   |
| item_shipping_fee_status | integer   | null:false                   |
| item_scheduled_delivery  | integer   | null:false                   |
| item_price               | integer   | null:false                   |
| user_id                  | references| null:false, foreign_key: true|

※ 画像はActiveStorageで実装するため含まない。

### Association
belongs_to :user
belongs_to :purchase_record

---

## ordersテーブル
| Column              | Type      | Options                  |
|---------------------|-----------|--------------------------|
| postal_code         | integer   | null:false               |
| item_prefecture     | integer   | null:false               |
| city                | string    | null:false               |
| addresses           | string    | null:false               |
| building            | string    |                          |
| phone_number        | string    | null:false               |


### Association
belongs_to :item

---

## purchase_recordテーブル
| Column              | Type      | Options                          |
|---------------------|-----------|----------------------------------|
| user_id             | references| null:false, foreign_key: true    |
| item_id             | references| null:false, foreign_key: true    |


### Association
belongs_to :user
belongs_to :item

---