class CreateAddresGs < ActiveRecord::Migration
  def change
    create_table :addres_gs do |t|
      t.integer :bomg
      t.string :subj
      t.string :indx
      t.string :okato
      t.string :rnname
      t.string :npname
      t.string :ul
      t.string :dom
      t.string :korp
      t.string :kv
      t.date :dreg
      t.references :person

      t.timestamps
    end
    add_index :addres_gs, :person_id
  end
end
