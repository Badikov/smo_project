class CreateAddresPs < ActiveRecord::Migration
  def change
    create_table :addres_ps do |t|
      t.string :subj
      t.string :indx
      t.string :okato
      t.string :rnname
      t.string :npname
      t.string :ul
      t.string :dom
      t.string :korp
      t.string :kv
      t.references :person

      t.timestamps
    end
    add_index :addres_ps, :person_id
  end
end
