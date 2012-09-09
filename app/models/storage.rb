class Storage < ActiveRecord::Base
  attr_accessible :id, :name
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
end
