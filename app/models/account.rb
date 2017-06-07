class Account
  include Mongoid::Document
  field :business_name, type: String

  belongs_to :dealer

  validates_presence_of :business_name, :dealer
end
