class Product < ActiveRecord::Base
  attr_accessible :name, :ppd_code, :supplier_code, :min_quantity, :size, :quantities_attributes, :quantities
  belongs_to :item
  has_many :quantities
  validate :amount_filled_out
  #validates :min_quantity, :presence => {:scope => :check_quant}
  #validates :name, :presence => true
  validates :name, :uniqueness => {:scope => :size}, :if => :name?
  validates :ppd_code, :uniqueness => true, :if => :ppd_code?
  validates :supplier_code, :uniqueness => {:scope => :size}, :if => :supplier_code?
    accepts_nested_attributes_for :quantities, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

def self.search(search)
  if search
  	@search_out = Array.new
    @arr = search.split(' ')
    @arr.collect! {|x| x + "%" }
    search = @arr.join
    logger.info search.inspect
    @prod_out = find(:all, :conditions => ['concat(name , size) ILIKE ? or supplier_code ILIKE ? or ppd_code ILIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    @prod_out.each do |prod| 
    	prod.quantities.each do |quants|
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
      errors.add(:base,"Amount has not been filled out!!!") if ( quant.amount.to_s == "" and 
        (name.to_s != "" or  ppd_code.to_s != "" or supplier_code.to_s != ""))
    end
end

def storage_filled_out
    self.quantities.each do |quant|
      errors.add(:base,"Storage has not been filled out where the Name has!") if ( quant.storage.to_s == "" and name.to_s != "" )
    end
end

end

public

def full_name
  self.name.to_s + " " + self.size.to_s
end