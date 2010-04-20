def get_crm_products_criteria_filters
  [
   { :model => Campaign, :filters => { :"products.id" => { :text => "product", :source => get_crm_products_criteria_options } } },
   { :model => Opportunity, :filters => { :"products.id" => { :text => "product", :source => get_crm_products_criteria_options } } },
  ]
end

def get_crm_products_criteria_options
  lambda { |options| Product.all.map { |product| [product.name, product.id] } }
end