module CrmProducts
  module ViewHelpers
  
    # Generate product links for use on asset index pages.
    #----------------------------------------------------------------------------
    def products_for_index(model)
      model.products.inject([]) do |arr, product|
        arr << product.name
      end.join(", ")
    end
    
    # Generate the collection select for edit
    #----------------------------------------------------------------------------    
    def get_products_colletion_select
      model = self.controller_name.singularize
      collection_select model, :product_ids, Product.find(:all), :id, :name, { }, { :multiple => true, :size => '10', :style => "width:240px" }
    end
    
  end
end

ActionView::Base.send(:include, CrmProducts::ViewHelpers)
