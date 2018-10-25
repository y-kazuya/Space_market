# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: ‘Star Wars’ }, { name: ‘Lord of the Rings’ }])
#   Character.create(name: ‘Luke’, movie: movies.first)

#テストuser作成
# 10.times do |a|
#   last_name = “test-#{a}”
#   first_name = “morita”
#   email = Faker::Internet.email
#   password = 12345678

#   user = User.create!(
#     last_name: last_name,
#     first_name: first_name,
#     email: email,
#     password: password,
#     password_confirmation: password
#   )

#   user.update!(admin: 1) if a ==1

#   if a > 3
#     #space_info作成
#     rand(3..5).times do |b|
#       postcode = rand(0000000..9999999)
#       state = rand(1..47)
#       city = Faker::Games::Pokemon.location
#       address = Faker::Address.street_address
#       last_address = Faker::Address.secondary_address
#       map_address = Faker::Address.country
#       access = Faker::Address.full_address
#       phone_number = rand(000..00000)
#       event_type = rand(1..17)
#       user_id = user.id

#       space_info = SpaceInfo.create!(
#         post_code: post_code,
#         state: state,
#         city: city,
#         address: address.
#         last_address: last_address,
#         map_address: map_address,
#         access: access,
#         phone_number: phone_number,
#         event_type: event_type,
#         user_id: user_id)
#     end
#     #space作成
#     rand(1..3).times do |c|
#       user_id = user.id
#       case c
#       when 1 then
#         space_info_id = user.space_infos.first.id
#       when 2 then
#         space_info_id = user.space_infos.second.id
#       else
#         space_info_id = user.space_infos.last.id
#       end

#       space = Space.create!{
#         user_id: user_id
#         s
#       }

#     end


#   end
# end





# 10.times do |n|
#   post_code  = rand(1000000..9999999)
#   state = rand(1..47)
#   city = Faker::Name.name
#   address = Faker::Name.name
#   last_address = Faker::Name.name
#   map_address = Faker::Name.name
#   access = Faker::Name.name
#   phone_number = rand(1..1000000)
#   event_type = rand(1..17)
#   user_id = rand(200..205)


#   s_i = SpaceInfo.create!(post_code:  post_code,
#       state: state,
#       city: city,
#       address: address,
#       last_address: last_address,
#       map_address: map_address,
#       access: access,
#       phone_number: phone_number,
#       event_type: event_type,
#       user_id: user_id)

#   s = Space.create!(
#       user_id: user_id,
#       space_info_id: s_i.id
#   )
#   end

 #usages作成
 usages = %W[パーティー 会議・研修 写真撮影 ロケ撮影 イベント 演奏・パフォーマンス 個展・展覧会 演奏・パフォーマンス スポーツ・フィットネス オフィス
             結婚式 その他]

 usages.each { |a| Usage.create(name: a) }
