FactoryBot.define do
  factory :diet do
    user
    starting_date { Date.today.to_s }
    ending_date { (Date.today + 21.days).to_s }
    current_weight { (rand(20) + 80) * 1000 }
    weight_goal { (rand(10) + 60) * 1000 }
  end
end
