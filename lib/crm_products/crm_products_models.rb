# Make relations on core models
#----------------------------------------------------------------------------
[ Campaign, Opportunity ].each do |klass|
  klass.class_eval do

    has_many :product_assets, :dependent => :destroy, :as => :asset
    has_many :products, :through => :product_assets    
    
  end
end