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
| encrypted_password  | string    | null:false               |
| last_name           | string    | null:false               |
| first_name          | string    | null:false               |
| last_name_kana      | string    | null:false               |
| first_name_kana     | string    | null:false               |
| birth_date          | date      | null:false               |


### Association
has_many :items
has_many :purchase_records

---

## itemsテーブル
| Column                 | Type      | Options                      |
|------------------------|-----------|------------------------------|
| name                   | string    | null:false                   |
| info                   | text      | null:false                   |
| category_id            | integer   | null:false                   |
| sales_status_id        | integer   | null:false                   |
| shipping_fee_id        | integer   | null:false                   |
| prefecture_id          | integer   | null:false                   |
| scheduled_delivery_id  | integer   | null:false                   |
| price                  | integer   | null:false                   |
| user                   | references| null:false, foreign_key: true|

※ 画像はActiveStorageで実装するため含まない。

### Association
belongs_to :user
has_one :purchase_record

---

## ordersテーブル
| Column              | Type      | Options                          |
|---------------------|-----------|----------------------------------|
| user                | references| null:false, foreign_key: true    |
| postal_code         | string    | null:false                       |
| item_prefecture_id  | integer   | null:false                       |
| city                | string    | null:false                       |
| addresses           | string    | null:false                       |
| building            | string    |                                  |
| phone_number        | string    | null:false                       |
| purchase_record     | references| null:false, foreign_key: true    |


### Association
belongs_to :purchase_record

---

## purchase_recordsテーブル
| Column              | Type      | Options                          |
|---------------------|-----------|----------------------------------|
| user                | references| null:false, foreign_key: true    |
| item                | references| null:false, foreign_key: true    |


### Association
belongs_to :user
belongs_to :item
has_one :order

---