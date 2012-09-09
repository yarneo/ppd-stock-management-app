class Product < ActiveRecord::Base
  attr_accessible :name, :quantities_attributes, :quantities
  belongs_to :item
  has_many :quantities
  validate :amount_filled_out, :storage_filled_out
  #validates :name, :presence => true
    accepts_nested_attributes_for :quantities, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

def self.search(search)
  if search
  	@search_out = Array.new
    @mrmr = find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    @mrmr.each do |element| 
    	element.quantities.each do |quants|
    		@search_out << quants
    	end
    end
    return @search_out
  else
    nil
  end
end

def amount_filled_out
    self.quantities.each do |quant|
      errors.add(:base,"Amount not been filled out where the Name has!") if ( quant.amount.to_s == "" and name.to_s != "" )
    end
end

def storage_filled_out
    self.quantities.each do |quant|
      errors.add(:base,"Storage has not been filled out where the Name has!") if ( quant.storage.to_s == "" and name.to_s != "" )
    end
end

end
