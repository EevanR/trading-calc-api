FactoryBot.define do
  factory :stripe_session do
    session_id { "MyString" }
    customer_id { "MyString" }
  end
end
