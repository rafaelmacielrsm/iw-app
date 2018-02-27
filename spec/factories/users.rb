FactoryBot.define do
  factory :user do
    name { FFaker::NameBR.name }
    email { FFaker::Internet.safe_email }
    password { FFaker::Internet.password }
    role 'member'
    height { 140 + rand(60) }

    trait :admin do
      role 'admin'
    end
  end
end
