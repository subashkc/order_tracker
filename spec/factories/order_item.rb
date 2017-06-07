FactoryGirl.define do
  factory :order_item do
    model 'Mustang'
    badge 'GT Fastback'
    colour 'Red'
    features 'MS'
    quantity 5
    order
  end
end
