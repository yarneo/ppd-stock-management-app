class Transaction < ActiveRecord::Base
  attr_accessible :info, :reason, :operationtype
end
