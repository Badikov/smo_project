class ChengeDataTypeInAts < ActiveRecord::Migration
  def up
    remove_column :ats, :date_z 
    remove_column :ats, :date_b 
    remove_column :ats, :date_e 
    add_column :ats, :date_z, :datetime 
    add_column :ats, :date_b, :datetime 
    add_column :ats, :date_e, :datetime 
    
  end

  def down
    remove_column :ats, :date_z 
    remove_column :ats, :date_b 
    remove_column :ats, :date_e
    add_column :ats, :date_z, :date 
    add_column :ats, :date_b, :date 
    add_column :ats, :date_e, :date
  end
end
