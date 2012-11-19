class CreateStreets < ActiveRecord::Migration
  def change
    create_table :streets do |t|
      t.integer :old_id
      t.string :name
    
    end
    add_index :streets, :name
  end
end
