# テーブル設計

## users テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| nickname           | string     | null: false |
| full_name          | string     | null: false |
| full_name_ruby     | string     | null: false |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false |
| birth_date         | datetime   | null: false |

### Association

- has_many :items
- has_many :comments
- has_many :purchase records
- has_many :shipping_addresses

## items テーブル

| Column                     | Type       | Options     |
| ---------------------------| ---------- | ----------- |
| product_name               | string     | null: false |
| category                   | string     | null: false |
| price                      | integer    | null: false |
| image                      | string     | null: false |
| product_condition          | string     | null: false |
| burden_of_shipping_charges | boolean    | null: false |
| delivery region            | string     | null: false |
| estimated_delivery_date    | string     | null: false |
| brand                      | string     | null: false |
| product_description        | text       | null: false |
| user                       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_one : purchase record

## comments テーブル

| Column  | Type       | Options     |
| --------| ---------- | ----------- |
| comment | text       | null: false |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## purchase records テーブル

| Column         | Type       | Options     |
| ---------------| ---------- | ----------- |
| purchased_item | text       | null: false |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one : shipping_address

## shipping_addresses テーブル

| Column           | Type       | Options     |
| -----------------| ---------- | ----------- |
| post_code        | integer    | null: false |
| prefectures      | string     | null: false |
| municipalities   | string     | null: false |
| street_address   | string     | null: false |
| building_name    | string     |             |
| telephone_number | integer    | null: false |
| purchase record  | references | null: false, foreign_key: true |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase record
- belongs_to :user