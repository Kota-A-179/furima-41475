FactoryBot.define do
  factory :purchase_address do
    post_code { "123-4567" }
    prefecture_id { "2" }
    city { "テスト市" }
    block { "テスト番地" }
    building { "テストマンション" }
    phone_number { "0987654321" }
  end
end