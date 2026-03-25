FactoryBot.define do
  factory :habit do
    user { nil }
    name { "MyString" }
    description { "MyText" }
    color { "MyString" }
    position { 1 }
    active { false }
    start_date { "2026-03-24" }
    current_streak { 1 }
    longest_streak { 1 }
  end
end
