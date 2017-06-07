class OrderItem
  include Mongoid::Document
  field :model, type: String
  field :badge, type: String
  field :colour, type: String
  field :features, type: String
  field :quantity, type: Integer
  belongs_to :order

  validates_presence_of :model, :badge, :colour, :features, :quantity, :order
  validates_numericality_of :quantity

  before_save :validate_features, :validate_availability

  def validate_features
    (self.features.split("") - Feature.distinct(:code)).empty?
  end

  def validate_availability
    item_description = {:model => self.model, :badge => self.badge}
    item_description[:colour] = self.colour unless self.features.include?('M') # color can be ignored for a metallic body, every color is available
    Vehicle.where(item_description).count > 0
  end
end
