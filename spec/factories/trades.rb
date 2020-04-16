FactoryBot.define do
  factory :trade do
    ticker { "APPL" }
    entry { 100.5 }
    shares { 1 }
    stop { 99.5 }
    setup { "Setup 1" }
    date { "20/05/14" }
    profit { 100.0 }
    trade_id { 1 }
  end
end
