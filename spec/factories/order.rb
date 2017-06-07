FactoryGirl.define do
  factory :order do
    delivery_date "2017-07-10"
    delivered false
    association :dealer
  end

  trait :order_without_dealer do
    dealer nil
  end

end
