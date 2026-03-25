FactoryBot.define do
  factory :habit_log do
    habit { nil }
    user { nil }
    completed_on { "2026-03-24" }
    notes { "MyText" }
  end
end
