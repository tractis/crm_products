class Product < ActiveRecord::Base
  has_many    :product_assets, :dependent => :destroy

  acts_as_paranoid

  validates_presence_of :name
  
end
