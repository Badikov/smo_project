class CreateFlks < ActiveRecord::Migration
  def change
    create_table :flks do |t|
      t.integer :rez
      t.references :at

      t.timestamps
    end
    add_index :flks, :at_id
  end
end
