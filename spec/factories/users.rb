FactoryBot.define do
  factory :user do
    first_name { "Test" }
    last_name { "Test" }
    sequence(:email) { |n| "test#{n}@gmail.com" }
    cellphone { "1234567895" }
    address { "Barranquilla" } 
    password { "123456789" }
    password_confirmation { "123456789" }
  end
end
