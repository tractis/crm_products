module CrmProducts
  module ViewHelpers
  
    # Generate product links for use on asset index pages.
    #----------------------------------------------------------------------------
    def products_for_index(model)
      model.class.to_s.constantize.find(model.id).products.inject([]) do |arr, product|
        arr << link_to(product.name, "#{send("search_#{model.class.to_s.downcase.pluralize}_path")}?query[products.id][match]=eq&query[products.id][value][]=#{product.id}")
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
