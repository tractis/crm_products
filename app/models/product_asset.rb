class ProductAsset < ActiveRecord::Base
  belongs_to :product
  belongs_to :asset, :polymorphic => true
end
