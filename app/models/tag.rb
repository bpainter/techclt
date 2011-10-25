class Tag < ActiveRecord::Base
  has_many :descriptors, :dependent => :destroy
  has_many :users, :through => :descriptors
end
