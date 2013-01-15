class NewOpsTable < ActiveRecord::Migration
  def up
    drop_table :ops
    
    create_table :ops do |t|
      t.string :tip_op, :limit => 4
      t.boolean :active, :null => false, :default => false
      t.date :date_uvoln
      
      t.references :person
      t.references :user
      t.timestamps 
      
    end
    add_index :ops, :user_id
    add_index :ops, :person_id
    add_index(:ops, [:user_id, :person_id], :unique => true)
    add_index :ops, :created_at
    add_index :ops, :updated_at
    add_index :ops, :active
  end
end
