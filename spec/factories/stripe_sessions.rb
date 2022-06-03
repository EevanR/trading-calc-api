FactoryBot.define do
  factory :stripe_session do
    session_id { "session_0001" }
    customer_id { "cus_00001" }
    user_id { "1" }
    association :user
  end
end
