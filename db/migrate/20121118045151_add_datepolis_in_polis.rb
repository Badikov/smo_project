class AddDatepolisInPolis < ActiveRecord::Migration
  def up
    add_column :polis, :datepolis, :date 
  end

  def down
    remove_column :polis, :datepolis, :date
  end
end
