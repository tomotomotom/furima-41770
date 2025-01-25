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
| カラム名             | 型        | 制約                     |
|----------------------|-----------|--------------------------|
| nickname            | string    | NOT NULL                |
| email               | string    | NOT NULL, ユニーク制約   |
| password            | string    | NOT NULL                |
| last_name           | string    | NOT NULL                |
| first_name          | string    | NOT NULL                |
| last_name_kana      | string    | NOT NULL                |
| first_name_kana     | string    | NOT NULL                |
| birth_date          | string    | NOT NULL                |


### Association
has_many :items
has_many :orders

---

## itemsテーブル
| カラム名             | 型        | 制約                     |
|----------------------|-----------|--------------------------|
| item_name           | string    | NOT NULL                |
| item_info           | text      | NOT NULL                |
| item_category       | string    | NOT NULL                |
| item-sales-status   | string    | NOT NULL                |
| item_shipping_fee_status | string  | NOT NULL             |
| item_prefecture     | string    | NOT NULL                |
| item_shipping_fee_status | string  | NOT NULL             |
| item_scheduled_delivery  | string  | NOT NULL             |
| item_price               | string  | NOT NULL             |

※ 画像はActiveStorageで実装するため含まない。

### Association
belongs_to :user

---

## ordersテーブル
| カラム名             | 型        | 制約                     |
|----------------------|-----------|--------------------------|
| postal_code         | string    | NOT NULL               |
| prefecture          | string    | NOT NULL               |
| city                | string    | NOT NULL               |
| addresses           | string    | NOT NULL               |
| building            | string    | NOT NULL               |
| phone_number        | string    | NOT NULL               |


### Association
belongs_to :item

---

## purchase_recordテーブル
| カラム名             | 型        | 制約                     |
|----------------------|-----------|--------------------------|
| user_id             | references| NOT NULL, 外部キー      |
| item_id             | references| NOT NULL, 外部キー      |


### Association
belongs_to :user
belongs_to :item

---