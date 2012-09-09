class Quantity < ActiveRecord::Base
  belongs_to :product
  attr_accessible :amount, :storage
  #validates :storage, :numericality => {:greater_than => 0, :less_than => (Storage.count+1), :message => "Storage doesnt exist!"} 
  validate :storage_exists
end


def storage_exists
	unless Storage.where(:id => storage).exists?
		errors.add(:base, 'Storage Doesnt Exist!')
	end
end
