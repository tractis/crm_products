class CrmProductsViewHooks < FatFreeCRM::Callback::Base
  
  PRODUCTS_FIELD = <<EOS
%tr
  %td{ :valign => :top, :colspan => span }
    .label= t(:select_products)
    = get_products_colletion_select
EOS

  PRODUCTS_FOR_INDEX = <<EOS
%dt
  .products
    %b= t(:products) + ": "
    = products_for_index(model)
EOS

  PRODUCTS_FOR_SHOW = <<EOS
%br
.products
  %b= t(:products) + ": "
  = products_for_index(model)
EOS

  #----------------------------------------------------------------------------
  [ :campaign, :opportunity ].each do |model|

    define_method :"#{model}_top_section_bottom" do |view, context|
      unless Product.find(:all).empty?  
        Haml::Engine.new(PRODUCTS_FIELD).render(view, :f => context[:f], :span => (model != :campaign ? 3 : 5))
      end
    end

    define_method :"#{model}_bottom" do |view, context|
      unless context[model].product_assets.empty?
        Haml::Engine.new(PRODUCTS_FOR_INDEX).render(view, :model => context[model])
      end
    end

    define_method :"show_#{model}_sidebar_bottom" do |view, context|
      unless context[model].product_assets.empty?
        Haml::Engine.new(PRODUCTS_FOR_SHOW).render(view, :model => context[model])
      end
    end
    
  end

end
