require 'rails_helper'

RSpec.describe Account, type: :model do
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

  it { is_expected.to belong_to :dealer }

  it "an account is associated with a dealer" do
    expect(build(:account).dealer).to be_a_kind_of(Dealer)
  end

end
