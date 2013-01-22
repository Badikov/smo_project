class NewVizitsTable < ActiveRecord::Migration
  def up
    drop_table :vizits
    
    create_table :vizits do |t|
      t.datetime :dvizit, :null => false
      t.string :method, :limit => 1, :null => false
      t.string :petition, :limit => 1, :null => false
      t.integer :rsmo
      t.integer :rpolis
      t.integer :fpolis
      t.integer :person_id, :null => false

      t.timestamps
    end
    add_index :vizits, :person_id
  end

  
end
