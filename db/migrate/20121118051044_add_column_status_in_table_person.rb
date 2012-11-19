class AddColumnStatusInTablePerson < ActiveRecord::Migration
  def up
    add_column :people, :status, :string
  end

  def down
    remove_column :people, :status, :string     
  end
end
