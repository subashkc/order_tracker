FactoryGirl.define do
  factory :dealer do

    after(:build) do |dealer, evaulator|
      dealer.account = build(:account, :dealer => dealer)
    end

  end
end
