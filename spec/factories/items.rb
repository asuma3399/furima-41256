FactoryBot.define do
  factory :item do
    product_name { Faker::Lorem.sentence }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    product_description { Faker::Lorem.paragraph(sentence_count: 2) }
    category_id { (2..5).to_a.sample }
    product_condition_id { (2..7).to_a.sample }
    burden_of_shipping_charges_id { (2..3).to_a.sample }
    delivery_region_id { (2..7).to_a.sample }
    estimated_delivery_date_id { (2..4).to_a.sample }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
