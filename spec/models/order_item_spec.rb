require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before :all do
    $continue = true
    Vehicle.create!({:model => 'Mustang', :colour => 'Red', :badge => 'GT Fastback'})
    Feature.create! [
      {code: 'M', full_name: 'metallic'},
      {code: 'S', full_name: 'seat warmers'}
    ]

  end

  let(:order_item) { OrderItem.new }

  around :each do |example|
    if $continue
      $continue = false
      example.run
      $continue = true unless example.exception
    else
      example.skip
    end
  end

  it { is_expected.to belong_to :order }

  it "has fields model, badge, colour, features and quantity" do
    expect(order_item).to respond_to(:model)
    expect(OrderItem).to have_field(:model).of_type(String)
    expect(order_item).to respond_to(:badge)
    expect(OrderItem).to have_field(:badge).of_type(String)
    expect(order_item).to respond_to(:colour)
    expect(OrderItem).to have_field(:colour).of_type(String)
    expect(order_item).to respond_to(:features)
    expect(OrderItem).to have_field(:features).of_type(String)
    expect(order_item).to respond_to(:quantity)
    expect(OrderItem).to have_field(:quantity).of_type(Integer)
  end

  it "has a parent order object" do
    expect(create(:order_item).order).to be_a_kind_of(Order)
  end

  it "must have all required attributes" do
    expect{create(:order_item, model: nil)}.to raise_error(Mongoid::Errors::Validations)
    expect{create(:order_item, badge: nil)}.to raise_error(Mongoid::Errors::Validations)
    expect{create(:order_item, colour: nil)}.to raise_error(Mongoid::Errors::Validations)
  end

end
