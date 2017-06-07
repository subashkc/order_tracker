FactoryGirl.define do
  factory :account do
    business_name "Ford"
    association :dealer    
  end
end
