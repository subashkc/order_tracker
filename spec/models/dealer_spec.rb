require 'rails_helper'

RSpec.describe Dealer, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before :all do
    $continue = true
  end

  around :each do |example|
    if $continue
      $continue = false
      example.run
      $continue = true unless example.exception
    else
      example.skip
    end
  end

  it { is_expected.to have_many :orders }
  it { is_expected.to have_one :account }

  it "a dealer has a account" do
    expect(build(:dealer).account).to be_a_kind_of(Account)
  end

end
