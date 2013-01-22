class NewPeopleTable < ActiveRecord::Migration
  def up
    drop_table :people
    
    create_table :people do |t|
      t.string :fam, :limit => 40, :null => false
      t.string :im, :limit => 40, :null => false
      t.string :ot, :limit => 40, :null => false
      t.integer :w, :null => false
      t.date :dr, :null => false
      t.integer :true_dr, :null => false
      t.string :c_oksm
      t.string :ss
      t.string :phone, :limit => 40
      t.string :email, :limit => 50
      t.string :status, :limit => 3 
      t.date :ddeath

      t.timestamps
    end
    add_index :people, :fam
    add_index :people, :dr
  end

  
end
