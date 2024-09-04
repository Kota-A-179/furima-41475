FactoryBot.define do
  factory :user do
    Faker::Config.locale = 'ja'  

    def generate_secure_password
      letters = Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 4, min_numeric: 2)
      digits = Faker::Number.number(digits: 2)
      letters + digits
    end  

    def hiragana_to_katakana(hiragana)
      hiragana.tr('ぁ-ん', 'ァ-ン')
    end

    nickname {Faker::Name.userName}
    email {Faker::Internet.email}
    password {generate_secure_password}
    password_confirmation {password}
    last_name {Faker::Name.lastName}
    first_name {Faker::Name.firstName}
    last_name_kana {hiragana_to_katakana(last_name)}
    first_name_kana {hiragana_to_katakana(first_name)}
    birthday {Faker::Date.birthday(min_age:5, max_age:94)}

  end
end