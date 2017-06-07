class Order
  include Mongoid::Document
  field :delivery_date, type: Date
  field :delivered, type: Mongoid::Boolean, default: false

  belongs_to :dealer
  has_many :order_items

  validates_presence_of :delivery_date, :dealer

  class << self
    def add_orders orders, dealer, delivery_date
      errors = []
      order = self.new({delivery_date: delivery_date, dealer: dealer})
      if order.save
        orders.each do |order_item|
          item = OrderItem.new({order: order, model: order_item['model'], badge: order_item['badge'], colour: order_item['colour'], features: order_item['features'], quantity: order_item['quantity']})
          item.save
          errors << "Vehicle of model : #{order_item['model']}, badge : #{order_item['badge']}, colour : #{order_item['colour']} and features : #{order_item['features']} unavailable." unless item.persisted?
        end
      else
        errors << order.errors
      end
      errors
    end

    def completed_orders
      where(:delivered => true).to_a
    end

    def all_outstanding_orders business_name=false
      self.where(:delivered => false).order_by(:delivery_date => 'asc').to_a.each { |order| puts "Dealer Id : #{order.dealer_id} - Ordered #{order.delivery_date.strftime('%d/%m/%Y')}"}
    end
  end

  def mark_complete
    self.delivered = true
    self.save!
  end

  # defines 3 methods total_order_by_color, total_order_by_badge and total_order_by_model
  ["model", "badge", "colour"].each do |vehicle_attribute|
    define_singleton_method("total_order_by_#{vehicle_attribute}") do
      OrderItem.collection.aggregate([{"$group" => {"_id" =>{vehicle_attribute => "$#{vehicle_attribute}"}, :total => {"$sum" => "$quantity"}}}]).each do |order_history|
        puts "#{order_history['_id'][vehicle_attribute]} -> #{order_history['total']} orders"
      end
    end
  end

end
