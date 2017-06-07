class Feature
  include Mongoid::Document
  field :code, type: String
  field :full_name, type: String
end
