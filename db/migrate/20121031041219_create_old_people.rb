class CreateOldPeople < ActiveRecord::Migration
  def change
    create_table :old_people do |t|
      t.string :fam
      t.string :im
      t.string :ot
      t.integer :w
      t.date :dr
      t.integer :old_enp
      t.references :person

      t.timestamps
    end
    add_index :old_people, :person_id
  end
end
