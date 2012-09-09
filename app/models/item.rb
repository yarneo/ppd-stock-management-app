class Item < ActiveRecord::Base
  attr_accessible :products_attributes
  has_many :products
  accepts_nested_attributes_for :products, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end