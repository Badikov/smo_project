class AddDateUvolnToOps < ActiveRecord::Migration
  def change
    remove_column :ops, :n_rec
    add_column :ops, :date_uvoln, :date
    add_column :ops, :active, :boolean
    
    add_index :ops, :active
  end
end
