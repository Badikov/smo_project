class NewPolisTable < ActiveRecord::Migration
  def up
    drop_table :polis
    
    create_table :polis do |t|
      t.integer :vpolis, :null => false
      t.string :npolis, :limit => 20
      t.string :spolis, :limit => 10
      t.datetime :dbeg
      t.date :dend
      t.date :dstop
      t.date :datepp
      t.date :datepolis
      t.integer :insurance_id, :null => false

      t.timestamps
    end
    add_index :polis, :insurance_id
  end
end
