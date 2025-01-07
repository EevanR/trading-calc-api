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
          :Commissions=>2.36,
          :Shares=>100,
          :Side=>"SS"
        }, 
        {
          :Ticker=>"FB", 
          :NetProfit=>23.0,
          :GrossProfit=>26.80,
          :ShareCount=> 0,
          :Commissions=>3.8,
          :Shares=>100,
          :Side=>"SS"
        },
        {
          :Ticker=>"YTEN", 
          :NetProfit=>23.44,
          :GrossProfit=>25.80,
          :ShareCount=> 0,
          :Commissions=>2.36,
          :Shares=>100,
          :Side=>"SS"
        }, 
        {
          :Ticker=>"ARC", 
          :NetProfit=>23.0,
          :GrossProfit=>26.80,
          :ShareCount=> 0,
          :Commissions=>3.8,
          :Shares=>100,
          :Side=>"SS"
        },
        {
          :Ticker=>"IMP", 
          :NetProfit=>23.44,
          :GrossProfit=>25.80,
          :ShareCount=> 0,
          :Commissions=>2.36,
          :Shares=>100,
          :Side=>"SS"
        }, 
        {
          :Ticker=>"IMTE", 
          :NetProfit=>23.0,
          :GrossProfit=>26.80,
          :ShareCount=> 0,
          :Commissions=>3.8,
          :Shares=>100,
          :Side=>"SS"
        },{
          :Ticker=>"DRYS", 
          :NetProfit=>23.44,
          :GrossProfit=>25.80,
          :ShareCount=> 0,
          :Commissions=>2.36,
          :Shares=>100,
          :Side=>"SS"
        }, 
        {
          :Ticker=>"CASA", 
          :NetProfit=>23.0,
          :GrossProfit=>26.80,
          :ShareCount=> 0,
          :Commissions=>3.8,
          :Shares=>100,
          :Side=>"SS"
        },
        {
          :Ticker=>"TSLA", 
          :NetProfit=>23.44,
          :GrossProfit=>25.80,
          :ShareCount=> 0,
          :Commissions=>2.36,
          :Shares=>100,
          :Side=>"SS"
        }, 
        {
          :Ticker=>"MSFT", 
          :NetProfit=>23.0,
          :GrossProfit=>26.80,
          :ShareCount=> 0,
          :Commissions=>3.8,
          :Shares=>100,
          :Side=>"SS"
        },
        {
          :Ticker=>"Q", 
          :NetProfit=>23.44,
          :GrossProfit=>25.80,
          :ShareCount=> 0,
          :Commissions=>2.36,
          :Shares=>100,
          :Side=>"SS"
        }, 
        {
          :Ticker=>"BB", 
          :NetProfit=>23.0,
          :GrossProfit=>26.80,
          :ShareCount=> 0,
          :Commissions=>3.8,
          :Shares=>100,
          :Side=>"SS"
        }
      ] 
    }
    fees { 78 }
  end
end
