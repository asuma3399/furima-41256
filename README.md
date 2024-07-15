# テーブル設計

## users テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| nickname           | string     | null: false |
| last_name          | string     | null: false |
| first_name         | string     | null: false |
| last_name_ruby     | string     | null: false |
| first_name_ruby    | string     | null: false |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false |
| birth_date         | datetime   | null: false |

### Association

- has_many :items
- has_many :comments
- has_many :purchase records
- has_many :shipping_addresses

## items テーブル

| Column                        | Type       | Options     |
| ------------------------------| ---------- | ----------- |
| product_name                  | string     | null: false |
| category_id                   | integer    | null: false |
| price                         | integer    | null: false |
| product_condition_id          | integer    | null: false |
| burden_of_shipping_charges_id | integer    | null: false |
| delivery_region_id            | integer    | null: false |
| estimated_delivery_date_id    | integer    | null: false |
| product_description           | text       | null: false |
| user                          | references | null: false, foreign_key: true |

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

## purchase_records テーブル

| Column         | Type       | Options     |
| ---------------| ---------- | ----------- |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses テーブル

| Column             | Type       | Options     |
| -------------------| ---------- | ----------- |
| post_code          | string     | null: false |
| delivery_region_id | integer    | null: false |
| municipality       | string     | null: false |
| street_address     | string     | null: false |
| building_name      | string     |             |
| telephone_number   | string     | null: false |
| purchase_record    | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_record