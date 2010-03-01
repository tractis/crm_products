class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string     :name
      t.text       :description
      
      t.timestamps
      t.datetime   :deleted_at
    end
    
    add_index :products, :deleted_at
  end
  
  def self.down
    drop_table :products
  end
end
