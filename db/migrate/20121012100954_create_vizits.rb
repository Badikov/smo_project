class CreateVizits < ActiveRecord::Migration
  def change
    create_table :vizits do |t|
      t.date :dvizit
      t.integer :method
      t.integer :petition
      t.integer :rsmo
      t.integer :rpolis
      t.integer :fpolis
      t.references :person

      t.timestamps
    end
    add_index :vizits, :person_id
  end
end
