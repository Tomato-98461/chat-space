# README

## DB設計 - 各テーブル

#### usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|

**Association**
- has_many :groups_users 
- has_many :messages
- has_many :groups, through: :groups_users

#### groupsテーブル
|Column|Type|Options|
|------|----|-------|
|group_name|string|null: false, foreign_key: true|

**Association**
- has_many :groups_users
- has_many :users, through: :groups_users
- has_many :messages

#### messagesテーブル
|Column|Type|Options|
|------|----|-------|
|message|text|null: false, foreign_key: true|
|image|string||
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

**Association**
- belongs_to :user, through: :groups_users
- belongs_to :group

#### groups_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

**Association**
- belongs_to :user
- belongs_to :group