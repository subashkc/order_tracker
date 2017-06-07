require 'rails_helper'

RSpec.describe Order, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before :all do
    $continue = true
  end

  let(:order) { Order.new }

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
  it { is_expected.to have_many :order_items }

  it "has fields delivery_date and delivered" do
    expect(order).to respond_to(:delivery_date)
    expect(Order).to have_field(:delivery_date).of_type(Date)
    expect(order).to respond_to(:delivered)
    expect(Order).to have_field(:delivered).of_type(Mongoid::Boolean)
  end

  it "an order is associated with a dealer" do
    expect(build(:order).dealer).to be_a_kind_of(Dealer)
  end

  it "new order is not complete" do
    expect(create(:order).delivered).to be false
  end

  it "can mark an order as completed" do
    sample_order = create(:order)
    expect(sample_order.delivered).to be false
    sample_order.mark_complete
    expect(sample_order.delivered).to be true
  end

  it "order can't exist without a dealer" do
    expect{create(:order, :order_without_dealer)}.to raise_error(Mongoid::Errors::Validations)
  end

  it "has methods to show total orders by model, badge, colour" do
    expect(Order).to respond_to(:total_order_by_badge)
    expect(Order).to respond_to(:total_order_by_model)
    expect(Order).to respond_to(:total_order_by_colour)
  end

end
