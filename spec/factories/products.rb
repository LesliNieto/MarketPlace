FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.material }
    quantity { 12 }
    price { Faker::Commerce.price }
    category_id { 1 }
    user_id { 1 }
  end
end
