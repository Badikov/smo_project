class RecreateDvizit < ActiveRecord::Migration
  def change
    
    remove_column :vizits, :dvizit
    add_column :vizits, :dvizit, :datetime, :null => false, :default => DateTime.now
    
    remove_column :polis, :dbeg
    add_column :polis, :dbeg, :datetime
  end
end
