# README

## ownersテーブル
|Column|Type|Options|
|------|----|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|email|string|null: false|
|password|string|null: false|
|image|text||

### Association
- has_many :partners through: :owners_partners
- has_many :communications through: :owners_communications
- has_one :address
- has_one :creditcard




## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|destination_name|string|null: false|
|post_code|integer|null: false|
|prefecture|string|null: false|
|address_1|string|null: false|
|address_2|string||
|telephone|integer|null: false|

### Association
- belongs_to :owner




## creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|creditcard_number|integer|null: false|
|creditcard_name|string|null: false|
|expire|integer|null: false|
|security_code|integer|null: false|

### Association
- belongs_to :owner




## owners_partnersテーブル
|Column|Type|Options|
|------|----|-------|
|owner|references|null: false, foreign_key: true|
|partner|references|null: false, foreign_key: true|

### Association
- belongs_to :owner
- belongs_to :partner




## owners_communicationsテーブル
|Column|Type|Options|
|------|----|-------|
|owner|references|null: false, foreign_key: true|
|communication|references|null: false, foreign_key: true|

### Association
- belongs_to :owner
- belongs_to :communication




## partners_communicationsテーブル
|Column|Type|Options|
|------|----|-------|
|partner|references|null: false, foreign_key: true|
|communication|references|null: false, foreign_key: true|

### Association
- belongs_to :partner
- belongs_to :communication




## partnersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|
|image|text||
|bank_name|string|null: false|
|bank_branch_name|string|null: false|
|account_number|string|null: false|
|account_name|string|null: false|

### Association
- has_many :owners through: :owners_partners
- has_many :plans
- has_many :communicatins through: :partners_communications




## plansテーブル
|Column|Type|Options|
|------|----|-------|
|closing_date|integer|null: false|
|registration_fee|integer|null: false|
|image|text||
|text|text||
|content_of_service|text|null: false|
|benefits|text|null: false|
|capacity|intger|null: false|
|wanted_period|intger|null: false|
|contract_period|intger|null: false|
|plan_schedule|intger|null: false|

### Association
- belongs_to :partner




## commnunicationsテーブル
|Column|Type|Options|
|------|----|-------|
|title|text|null: false|
|image|text||
|text|text||
|owner|references|null: false, foreign_key: true|
|partner|references|null: false, foreign_key: true|

### Association
- belongs_to :owner
- belongs_to :partner
