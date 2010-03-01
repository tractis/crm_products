class CreateProductAssets < ActiveRecord::Migration
  def self.up
    create_table :product_assets do |t|
      t.integer    :product_id
      
      t.references :asset, :polymorphic => true

      t.timestamps
    end
    
    add_index :product_assets, [:asset_id, :asset_type]
  end
  
  def self.down
    drop_table :product_assets
  end
end
