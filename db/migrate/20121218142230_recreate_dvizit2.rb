class RecreateDvizit2 < ActiveRecord::Migration
  def change
    
    remove_column :vizits, :dvizit
    add_column :vizits, :dvizit, :datetime
  
  end
end
