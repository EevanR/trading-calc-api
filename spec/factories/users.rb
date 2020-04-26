FactoryBot.define do
  factory :user do
    email { "user@random.com" }
    nickname { "UserMan" }
    password { "password" }
    password_confirmation { "password" }
    risk { 0.01 }
  end
end
