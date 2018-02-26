FactoryBot.define do
  factory :user do
    name 'Average Joe'
    email 'avjoe@foo.bar'
    password '12345678'
    role 'member'
    height 175

    trait :admin do
      role 'admin'
    end
  end
end
