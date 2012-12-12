class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives do |t|
      t.string :fam
      t.string :im
      t.string :ot
      t.string :parent
      t.string :doctype
      t.string :docser
      t.string :docnum
      t.date :docdate
      t.string :phone
      
      t.references :person

      t.timestamps
    end
    add_index :representatives, :person_id
  end
end
