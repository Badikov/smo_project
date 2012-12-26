class AddReferenceInUser < ActiveRecord::Migration
  def change
    add_column :users, :filial_id, :integer
    add_index :users, :filial_id
  end

end
