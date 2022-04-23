FactoryBot.define do
  factory :excel do
    user_id { 1 }
    data { 
      [
        {
          :Ticker=>"AMC", 
          :NetProfit=>23.44,
          :GrossProfit=>25.80,
          :ShareCount=> 0,
          :Commissions=>2.36
        }, 
        {
          :Ticker=>"FB", 
          :NetProfit=>23.0,
          :GrossProfit=>26.80,
          :ShareCount=> 0,
          :Commissions=>3.8
        }
      ] 
    }
    fees { 78 }
  end
end
