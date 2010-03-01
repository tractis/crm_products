require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_products, initializer) do
          name "Fat Free CRM Products"
       authors "Tractis - https://www.tractis.com - Jose Luis Gordo Romero"
       version "0.1"
   description "Adds products to all major models"
  dependencies :haml
           tab :admin do |tabs|
             tabs.insert(2, { :text => "products", :url => { :controller => "products" } })
           end 
end

require "crm_products"