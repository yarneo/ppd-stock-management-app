class Transaction < ActiveRecord::Base
  attr_accessible :info, :reason, :operationtype
end
 public

def merge(sales)
  @name = sales.first.name.to_s
  @quant = 0
  @merge_out = Array.new
  sales.each do |sal|
  	if @name == sal.name.to_s
  	  @quant += sal.quantity.to_i
  	else
      @merge_out << Sales.new(:name => @name, :quantity => @quant)

      @quant = sal.quantity.to_i
      @name = sal.name.to_s
    end
    if sal == sales.last
  	  @merge_out << Sales.new(:name => @name, :quantity => @quant)
    end
  end
  return @merge_out
end
