# 🛍️ Furima（フリマアプリ）

![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red)
![Rails](https://img.shields.io/badge/Rails-6.1.7.3-red)
![MIT](https://img.shields.io/badge/License-MIT-brightgreen)
![Made with Ruby](https://img.shields.io/badge/Made%20with-Ruby-red)

![furima_demo](https://user-images.githubusercontent.com/your-image-path/demo.gif)

---

## 🌟 サービス概要

Furimaは、ユーザー同士が商品を出品・購入できるCtoC型のフリマアプリです。  
ユーザーは会員登録後、画像付きで商品を出品し、他のユーザーがクレジットカードを使って購入できます。

---

## 🌐 アプリURL

🔗 [http://18.178.92.54/](http://18.178.92.54/)

---

## 📝 開発背景

近年、個人間取引の需要が高まる中、安全で使いやすいフリマアプリの必要性を感じ、Furimaを開発しました。  
ユーザーが簡単に商品を出品・購入できるプラットフォームを目指しています。

---

## 📸 画面イメージと機能説明

| 画面 | 説明 |
|---|---|
| ![トップページ](https://gyazo.com/54c5d85a9bdef4d4a7cb4d338c4fb30c) | **トップページ**<br>新着商品が一覧表示されます。 |
| ![商品詳細](https://gyazo.com/c53e6c7a304149590a67ff75693c2b10) | **商品詳細ページ**<br>商品の詳細情報を確認できます。 |
| ![商品出品](https://gyazo.com/7439dc665f3e59268ec7f048c4873e47) | **商品出品ページ**<br>商品情報を入力して出品できます。 |
| ![購入画面](https://gyazo.com/29d7032db905793e8460bde0f20d7dd7) | **購入画面**<br>クレジットカード情報を入力して購入できます。 |

---

## 🛠️ 使用技術

- **フロントエンド**: HTML, SCSS, JavaScript
- **バックエンド**: Ruby on Rails 6
- **データベース**: MySQL
- **インフラ**: AWS EC2 / S3
- **決済**: PayJP（テストモード）
- **その他**: ActiveStorage（画像アップロード）, RSpec（テスト）

---

## 📊 データベース設計

### usersテーブル

| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | date   | null: false               |

**Association**

- has_many :items  
- has_many :purchase_records

---

### itemsテーブル

| Column                | Type       | Options                        |
|-----------------------|------------|--------------------------------|
| name                  | string     | null: false                    |
| info                  | text       | null: false                    |
| category_id           | integer    | null: false                    |
| sales_status_id       | integer    | null: false                    |
| shipping_fee_id       | integer    | null: false                    |
| prefecture_id         | integer    | null: false                    |
| scheduled_delivery_id | integer    | null: false                    |
| price                 | integer    | null: false                    |
| user                  | references | null: false, foreign_key: true |

**Association**

- belongs_to :user  
- has_one :purchase_record

---

### ordersテーブル

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| postal_code        | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| addresses          | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| purchase_record    | references | null: false, foreign_key: true |

**Association**

- belongs_to :purchase_record

---

### purchase_recordsテーブル

| Column | Type       | Options                        |
|--------|------------|--------------------------------|
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

**Association**

- belongs_to :user  
- belongs_to :item  
- has_one :order

---

## 🚀 ローカル環境でのセットアップ

```bash
git clone https://github.com/tomotomotom/furima-41770.git
cd furima-41770
bundle install
yarn install
rails db:create
rails db:migrate
rails s
