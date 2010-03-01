module Admin::ProductsHelper

  #----------------------------------------------------------------------------
  def link_to_confirm(product)
    link_to_remote(t(:delete) + "?", :method => :get, :url => confirm_admin_product_path(product))
  end

  #----------------------------------------------------------------------------
  def link_to_delete(product)
    link_to_remote(t(:yes_button), 
      :method => :delete,
      :url => admin_product_path(product),
      :before => visual_effect(:highlight, dom_id(product), :startcolor => "#ffe4e1")
    )
  end
  
end