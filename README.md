# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|last_name|string|null:false|
|first_name|string|null:false|
|company|string||
|email|string|unique:true,null:false|
|avatar|string||
|profile|text||
|URL|string|unique:true|
|timezone|integer||

### Asosiation
- has_many credits
- has_many favorite
- has_many reservations
- belongs_to contact

## creditsテーブル
|Column|Type|Options|
|------|----|-------|
|number|integer|unique:true,null:false|
|last_name|string|null:false|
|first_name|string|null:false|
|data|integer|null:false|
|user_id|integer|refarence:true|

### Asosiation
- belongs_to user

## favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|space_id|integer|null:false|
|user_id|integer|null:false|

### Asosiation
- belongs_to user

## contactsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|industry|integer||
|job|integer||
|Corporation|boolean||
|phone_number|integer|unique:true|
|postal_code|integer|null:false|
|prefecture|integer|null:false|
|municipal_district|string|null:false|
|building|string|null:false|
|user_id|integer|reference:true|

### Asosiation
- belongs_to user

## reservationsテーブル
|Column|Type|Options|
|------|----|-------|
|space_id|integer||
|user_id|integer||
|date|date||
|time|time||

### Asosiation
- belongs_to user
- belongs_to space

## spacesテーブル
|Column|Type|Options|
|------|----|-------|
|space|string|null:false,unique:true|
|postal_code|integer|null:false|
|prefecture|integer|null:false|
|municipal_district|string|null:false|
|building|string|null:false|
|capacity|integer||
|floor_space|integer||
|term|integer|null:false|
|introduction|text||
|service|text||

### Asosiation
- has_many images
- has_many space_tags
- has_many space_plans
- has_many space_usages
- has_many space_amenities
- has_many reviewies
- has_many favorites
- has_many reservations
- has_many available_dates

## available_datesテーブル
|Column|Type|Options|
|------|----|-------|
|space_id|integer|reference:true|
|date|date|null:false|
|time|time|null:false|

### Asosiation
- belongs_to space

## space_plansテーブル
|Column|Type|Options|
|------|----|-------|
|space_id|integer|reference:true|
|plan_id|integer|reference:true|

### Asosiation
- belongs_to space
- belongs_to plan

## plansテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
|detail|string||

### Asosiation
- has_many space_plans

## space_tagsテーブル
|Column|Type|Options|
|------|----|-------|
|space_id|integer|reference:true|
|tag_id|integer|reference:true|

### Asosiation
- belongs_to space
- belongs_to tag

## tagsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

### Asosiation
- has_many space_tags

## space_usagesテーブル
|Column|Type|Options|
|------|----|-------|
|space_id|integer|reference:true|
|usage_id|integer|reference:true|

### Asosiation
- belongs_to space
- belongs_to usage

## usagesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

### Asosiation
- has_many space_usages

## space_amenitiesテーブル
|Column|Type|Options|
|------|----|-------|
|space_id|integer|reference:true|
|tag_id|integer|reference:true|

### Asosiation
- belongs_to space
- belongs_to ameniti

## amenitiesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

### Asosiation
- has_many space_amenities

## reviewsテーブル
|Column|Type|Options|
|------|----|-------|
|space_id|integer|reference:true|
|user_id|integer|reference:true|
|content|text|null:false|
|sccore|integer|null:false|

### Asosiation
- belongs_to space







* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
