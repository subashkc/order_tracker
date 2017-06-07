class Vehicle
  include Mongoid::Document
  field :model, type: String
  field :badge, type: String
  field :colour, type: String

  validates_presence_of :model, :badge, :colour

  def self.stock_levels
    OrderItem.collection.aggregate([{"$group" => {"_id" =>{:model => "$model"}, :total => {"$sum" => "$quantity"}}}, {"$sort" => { total: 1 }}]).each do |vehicle_stock_info|
      puts "#{vehicle_stock_info['_id']['model']} -> #{vehicle_stock_info['total']}"
    end
  end
end
