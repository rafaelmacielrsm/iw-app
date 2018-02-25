FactoryBot.define do
  factory :user do
    name 'Average Joe'
    email 'avjoe@foo.bar'
    password '12345678'
    role 'member'

    trait :admin do
      role 'admin'
    end
  end
end
