class RemoveMethodPetitionFromVizits < ActiveRecord::Migration
  def up
    remove_column :vizits, :method
    remove_column :vizits, :petition
    add_column :vizits, :petition, :string, :limit => 1
    add_column :vizits, :method, :string, :limit => 1
  end

  def down
    remove_column :vizits, :method
    remove_column :vizits, :petition
    add_column :vizits, :petition, :string, :limit => 1
    add_column :vizits, :method, :string, :limit => 1
  end
end
