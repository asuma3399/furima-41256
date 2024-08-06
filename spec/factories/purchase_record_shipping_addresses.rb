FactoryBot.define do
  factory :purchase_record_shipping_address do
    post_code { '123-4567' }
    delivery_region_id { (2..7).to_a.sample }
    municipality { '東京都' }
    street_address { '1-1' }
    building_name { '東京ハイツ' }
    telephone_number { '0901234567'}
    token {"tok_abcdefghijk00000000000000000"}
  end
end