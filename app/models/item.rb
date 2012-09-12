class Item < ActiveRecord::Base
  attr_accessible :products_attributes
  has_many :products
  accepts_nested_attributes_for :products, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  validate :more_than_two, :on => :create
  
  def more_than_two
  self.products.each do |prod|
  if (!prod.name.blank? and !prod.ppd_code.blank?) or (!prod.ppd_code.blank? and !prod.supplier_code.blank?) or (!prod.name.blank? and !prod.supplier_code.blank?)
    errors.add(:base,"You cant add stocks with more than two fields!!")
  end
	end
end

end