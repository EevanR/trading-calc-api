FactoryBot.define do
  factory :stripe_session do
    session_id { "session_0001" }
    customer_id { "cus_00001" }
    user_id { "1" }
    status { "pending" }
    association :user
  end
end
