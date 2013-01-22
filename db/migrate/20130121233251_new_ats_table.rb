class NewAtsTable < ActiveRecord::Migration
  def up
    drop_table :ats
    
    create_table :ats do |t|
      t.string :type_at, :null => false, :limit => 1
      t.integer :kdatemu, :null => false
      t.integer :kdmu, :null => false
      t.datetime :date_z
      t.datetime :date_b, :null => false
      t.datetime :date_e
      t.integer :person_id, :null => false

      t.timestamps
    end
    add_index :ats, :person_id
    add_index(:ats, [:kdatemu, :kdmu])
  end

  
end
