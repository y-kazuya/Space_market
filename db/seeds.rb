# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: ‘Star Wars’ }, { name: ‘Lord of the Rings’ }])
#   Character.create(name: ‘Luke’, movie: movies.first)

#素でテータ
citys = %W[高知市 南国市 須崎市 室戸市 渋谷 境港 新宿 梅田 鳥取 京都 北海道 名古屋 滋賀 森田家 ]
weeks_day = %W[祝日 日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日]

 #usages作成
 usages = %W[パーティー 会議・研修 写真撮影 ロケ撮影 イベント 演奏・パフォーマンス 個展・展覧会 演奏・パフォーマンス スポーツ・フィットネス オフィス
  結婚式 その他]


usages.each { |a| Usage.create(name: a) }

#amenities作成
amenitise = %W[テーブル 椅子 プロジェクター 駐車場 WIFI ホワイトボード プリンター キッチン設備 調理機材 テレビ ロッカー ケータリング バー 音響設備 ミラー シャワー 更衣室 照明設備 写真撮影機材 動画撮影機材 公共交通機関 トイレ 冷蔵庫 電源 冷暖房 周辺に飲食店 スーパー/コンビニ バリアフリー 飲酒可 ペット可 子連れ可 喫煙可]

amenitise.each { |a| Amenity.create(name: a) }

#テストuser作成
if User.last
  pp = User.last.id + 1
else
  pp = 1
end


30.times do |a|



  last_name = "test-#{pp + a}"
  first_name = "morita"
  email = "test-#{pp + a}@test.com"
  password = 12345678

  user = User.create!(
    last_name: last_name,
    first_name: first_name,
    email: email,
    password: password,
    password_confirmation: password
  )

  user.update!(first_name: "machida", admin: 1) if a == 1 || a == 2

  if a > 10
    #space_info作成
    rand(1..5).times do |b|
      post_code = 1234567
      state = rand(1..47)
      city = citys.sample
      address = Faker::Address.street_address
      last_address = Faker::Address.secondary_address
      map_address = Faker::Address.country
      access = Faker::Address.full_address
      phone_number = rand(000..00000)
      event_type = rand(1..17)
      user_id = user.id

      space_info = SpaceInfo.create!(
        post_code: post_code,
        state: state,
        city: city,
        address: address,
        last_address: last_address,
        map_address: map_address,
        access: access,
        phone_number: phone_number,
        event_type: event_type,
        user_id: user_id)
    end
    #space作成
    rand(1..3).times do |c|
      user_id = user.id


      space = Space.create!(
        user_id: user_id,
        space_info_id: user.space_infos.sample.id
      )

      #room作成
      rand(1..5).times do |d|

        room = space.rooms.create!()

        if  rand(1..3) == 2
          room.update!(activated: 2)
        elsif rand(1..3) == 3
          room.update!(activated: 1)
        end

        #basic_info作成
        capacity = rand(30..999)
        floor_space = rand(50..10000)
        key_type = rand(1..4)
        reserve_limit = rand(1..6)
        reserve_period = rand(1..4)

        basic_info = BasicInfo.new(
          capacity: capacity,
          floor_space: floor_space,
          key_type: key_type,
          reserve_limit: reserve_limit,
          reserve_period: reserve_period,
          room_id: room.id
        )
        rand(1..7).times do |e|
          basic_info.usages << Usage.find(rand(1..11))
        end
        basic_info.save!

        #intro作成
        title = "ルームむの見出しです#{Faker::DragonBall.character}#{rand(1..1000000000000)}"
        content = Faker::NewGirl.quote
        service = Faker::Lorem.paragraph(2, false, 4)

        intro = Intro.create!(
          title: title,
          content: content,
          service: service,
          room_id: room.id
        )

        #ピクチャー作成
        image =  Rails.root.join("app/assets/images/funa.jpg").open
        content = image
        about = Faker::Food.dish
        cover = 0

        picture = Picture.create!(
          content: image,
          about: about,
          cover: cover,
          room_id: room.id
        )

        if rand(1..2) == 2
          image =  Rails.root.join("app/assets/images/sin.jpg").open
          content = image
          about = Faker::Food.dish
          cover = 1

          picture = Picture.create!(
            content: content,
            about: about,
            cover: cover,
            room_id: room.id
          )
        end


        #plan作成
        rand(1..3).times do |f|
          name = Faker::Food.fruits
          about =  Faker::Lorem.sentence(3, false, 4)
          day_pay = 1
          day_price = rand(500..11000)
          time_pay = rand(0..1)
          time_price = rand(200..1000)
          about_reserve = rand(0..1)

          plan = Plan.new(
            name: name,
            about: about,
            day_pay: day_pay,
            day_price: day_price,
            time_pay: time_pay,
            time_price: time_price,
            about_reserve: about_reserve,
            room_id: room.id
          )

          weeks_day.each do |day|
            name = day
            start_time = rand(1..5)
            end_time = rand(6..24)
            can = 1

            week = Week.new(
              name: name,
              start_time: start_time,
              end_time: end_time,
              can: can
            )
            plan.weeks << week
          end
          plan.save!
        end
      end
    end

    #ホストプロフィール作成
    last_name = Faker::Name.last_name
    first_name = Faker::Name.first_name
    last_name_kata = "ラストネームダヨ"
    first_name_kata = "ファーストネームダヨ"
    sex = rand(0..1)
    born_year = rand(1991..2015)
    born_manth = rand(1..12)
    born_day = rand(1..27)
    avatar = Rails.root.join("app/assets/images/funa.jpg").open
    phone_number = rand(1..99999999)
    identification = Rails.root.join("app/assets/images/funa.jpg").open
    company = rand(0..1)
    if company == 1
      company_name = Faker::Company.name
      company_name_kata = "カイシャメイダヨ"
      company_name_en = "hi"
      company_number = rand(11..9999)

      host_profile = HostProfile.create!(
        last_name: last_name,
        first_name: first_name,
        last_name_kata: last_name_kata,
        first_name_kata: first_name_kata,
        sex: sex,
        born_year: born_year,
        born_day: born_day,
        born_manth: born_manth,
        avatar: avatar,
        phone_number: phone_number,
        identification: identification,
        company: 1,
        company_name: company_name,
        company_name_kata: company_name_kata,
        company_name_en: company_name_en,
        company_number: company_number,
        user_id: user.id
      )
    else
      host_profile = HostProfile.create!(
        last_name: last_name,
        first_name: first_name,
        last_name_kata: last_name_kata,
        first_name_kata: first_name_kata,
        sex: sex,
        born_year: born_year,
        born_day: born_day,
        born_manth: born_manth,
        avatar: avatar,
        phone_number: phone_number,
        identification: identification,
        company: 0,
        user_id: user.id
      )
    end

    #ホストアドレス追加
    post_code = rand(1111111..9999999)
    state = rand(1..47)
    city = citys.sample
    city_kata = "マチノナマエデスノナマエデス"
    address = Faker::Address.street_name
    address_kata = "ジュウショデス"
    last_address = Faker::Address.secondary_address
    last_address_kata = "サイゴノヤツデス"
    building = Faker::Address.city_suffix

    host_address = HostAddress.create!(
      post_code: post_code,
      state: state,
      city: city,
      city_kata: city_kata,
      address: address,
      address_kata: address_kata,
      last_address: last_address,
      last_address_kata: last_address_kata,
      building: building,
      host_profile_id: host_profile.id
    )

    if company == 1
      company_address = CompanyAddress.create!(
        post_code: post_code,
        state: state,
        city: city,
        city_kata: city_kata,
        address: address,
        address_kata: address_kata,
        last_address: last_address,
        last_address_kata: last_address_kata,
        building: building,
        host_profile_id: host_profile.id
      )
    end


    #振込口座追加
    bank_name = Faker::Dog.name
    bank_code = rand(1111..9999)
    branch_name = Faker::Address.country_code_long
    branch_code = rand(111..999)
    account_number = Faker::Bank.account_number(4)
    account_name = "コウザメイギダヨ"

    host_bank = HostBank.create!(
      bank_name: bank_name,
      bank_code: bank_code,
      branch_name: branch_name,
      branch_code: branch_code,
      account_number: account_number,
      account_name: account_name,
      host_profile_id: host_profile.id
    )
  end
end


