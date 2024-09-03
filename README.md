# テーブル設計

## users テーブル

| Column             | Type   | Options                 |
| ------------------ | ------ | ----------------------- |
| nickname           | string | null:false, unique:true |
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

| Column        | Type       | Options                      |
| ------------- | ---------- | ---------------------------- |
| name          | string     | null:false                   |
| content       | text       | null:false                   |
| category      | string     | null:false                   |
| condition     | string     | null:false                   |
| expense       | string     | null:false                   |
| source        | string     | null:false                   |
| shipping_date | string     | null:false                   |
| price         | integer    | null:false                   |
| user_id       | references | null:false, foreign_key:true |

### Association

- belongs_to :user
- has_one :purchases

## purchases テーブル

| Column  | Type       | Options                      |
| ------- | ---------- | ---------------------------- |
| item_id | references | null:false, foreign_key:true |
| user_id | references | null:false, foreign_key:true |

### Association

-belongs_to :item
-belongs_to :user
-has_one :address

## addresses テーブル

| Column      | Type       | Options                      |
| ----------- | ---------- | ---------------------------- |
| post_code   | string     | null:false                   |
| prefecture  | string     | null:false                   |
| city        | string     | null:false                   |
| block       | string     | null:false                   |
| building    | string     |                              |
| purchase_id | references | null:false, foreign_key:true |

### Association

-belongs_to :purchase
