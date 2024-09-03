# テーブル設計

## users テーブル

| Column             | Type   | Options                 |
| ------------------ | ------ | ----------------------- |
| nickname           | string | null:false              |
| email              | string | null:false, unique:true |
| encrypted_password | string | null:false              |
| last_name          | string | null:false              |
| first_name         | string | null:false              |
| last_name_kana     | string | null:false              |
| first_name_kana    | string | null:false              |
| birthday           | date   | null:false              |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column           | Type       | Options                      |
| ---------------- | ---------- | ---------------------------- |
| name             | string     | null:false                   |
| content          | text       | null:false                   |
| category_id      | integer    | null:false                   |
| condition_id     | integer    | null:false                   |
| expense_id       | integer    | null:false                   |
| prefecture_id    | integer    | null:false                   |
| shipping_date_id | integer    | null:false                   |
| price            | integer    | null:false                   |
| user             | references | null:false, foreign_key:true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column | Type       | Options                      |
| ------ | ---------- | ---------------------------- |
| item   | references | null:false, foreign_key:true |
| user   | references | null:false, foreign_key:true |

### Association

-belongs_to :item
-belongs_to :user
-has_one :address

## addresses テーブル

| Column        | Type       | Options                      |
| ------------- | ---------- | ---------------------------- |
| post_code     | string     | null:false                   |
| prefecture_id | integer    | null:false                   |
| city          | string     | null:false                   |
| block         | string     | null:false                   |
| building      | string     |                              |
| phone_number  | string     | null:false                   |
| purchase      | references | null:false, foreign_key:true |

### Association

-belongs_to :purchase
