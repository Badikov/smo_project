class RenameColumnTypeInAts < ActiveRecord::Migration
  def chenge
    
    add_column :ats, :type_at, :string, :limit => 1
    
  end

  
end
