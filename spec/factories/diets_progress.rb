FactoryBot.define do
  factory :diet_progress do
    diet
    weighing_date { (Date.today + rand(20).days).to_s }
    weight { (rand(9) + 70) * 1000 }
  end
end
