FactoryBot.define do
  factory :excel do
    user_id { 1 }
    data { [{:Ticker=>"AMC", :NetProfit=>23.44}, {:Ticker=>"FB", :NetProfit=>23.0}] }
    fees { 78 }
  end
end
