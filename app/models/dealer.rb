class Dealer
  include Mongoid::Document

  has_one :account
  has_many :orders

  def outstanding_orders
    orders.where(:delivered => false).to_a
  end

end
