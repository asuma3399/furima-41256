FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    last_name             { %w[佐藤 鈴木 高橋 田中].sample }
    first_name            { %w[太郎 次郎 三郎 四郎].sample }
    last_name_ruby        { Gimei.name.last.katakana }
    first_name_ruby       { Gimei.name.first.katakana }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    birth_date            { Faker::Date.birthday(min_age: 20, max_age: 65) }
  end
end
